#!/usr/bin/env bash
# LEAP render.sh — tools for managing role-tailored CV variants.
#
# Usage:
#   ./_shared/render.sh new <Company> <Role>      Bootstrap a new tailored variant from Vanilla
#   ./_shared/render.sh build <Company> <Role>    Render PDF + preview PNG for an existing variant
#   ./_shared/render.sh render <html-path>        Render PDF + preview PNG for a specific HTML
#   ./_shared/render.sh status                    List all variants with page counts and sizes
#
# Examples:
#   ./_shared/render.sh new AWS LATAM-Strategy-Manager
#   # ...edit AWS/CV_AWS_LATAM-Strategy-Manager.{html,md}...
#   ./_shared/render.sh build AWS LATAM-Strategy-Manager
#
# Conventions:
#   - Use hyphens in <Role> (e.g., BPM-LATAM, LATAM-Strategy-Manager).
#   - Each <Company>/ folder is a sibling of _shared/ at the outputs/ root.
#   - All HTMLs reference ../_shared/profile.jpg for the header photo.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUTS_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
VANILLA_DIR="$OUTPUTS_DIR/Vanilla"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"

usage() {
  cat >&2 <<EOF
Usage:
  $(basename "$0") new <Company> <Role>            Bootstrap a new tailored variant from Vanilla
  $(basename "$0") build <Company> <Role>          Render PDF + preview PNG for an existing variant
  $(basename "$0") render <html-path>              Render PDF + preview PNG for a specific HTML
  $(basename "$0") status                          List all variants with page counts and sizes

Examples:
  $(basename "$0") new AWS LATAM-Strategy-Manager
  $(basename "$0") build Google BPM-LATAM
  $(basename "$0") render Google/CV_Google_BPM-LATAM.html
EOF
}

require_chrome() {
  if [[ ! -x "$CHROME" ]]; then
    echo "ERROR: Google Chrome not found at $CHROME" >&2
    echo "Set the CHROME environment variable to your Chrome binary path." >&2
    exit 1
  fi
}

cmd_new() {
  local company="$1" role="$2"
  local target_dir="$OUTPUTS_DIR/$company"
  local stem="CV_${company}_${role}"
  local html_target="$target_dir/$stem.html"
  local md_target="$target_dir/$stem.md"

  if [[ -e "$html_target" || -e "$md_target" ]]; then
    echo "ERROR: target already exists — refusing to overwrite." >&2
    echo "  $html_target" >&2
    echo "  $md_target" >&2
    echo "Delete or rename the existing files first, or use 'build' to re-render." >&2
    exit 1
  fi

  mkdir -p "$target_dir"
  cp "$VANILLA_DIR/CV.html" "$html_target"
  cp "$VANILLA_DIR/CV.md" "$md_target"

  python3 - "$html_target" "$company" "$role" <<'PY'
import re, sys
path, company, role = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path) as f:
    html = f.read()
html = re.sub(
    r"<title>[^<]*</title>",
    f"<title>CV ({company} — {role})</title>",
    html,
    count=1,
)
with open(path, "w") as f:
    f.write(html)
PY

  echo "Bootstrapped new variant from Vanilla:"
  echo "  $html_target"
  echo "  $md_target"
  echo ""
  echo "Next steps:"
  echo "  1. Edit $stem.html (and mirror your changes into $stem.md)"
  echo "  2. Run: $(basename "$0") build $company $role"
}

cmd_render() {
  local html_path="$1"

  if [[ ! -f "$html_path" && -f "$OUTPUTS_DIR/$html_path" ]]; then
    html_path="$OUTPUTS_DIR/$html_path"
  fi
  if [[ ! -f "$html_path" ]]; then
    echo "ERROR: HTML not found: $1" >&2
    exit 1
  fi

  require_chrome

  local pdf_path="${html_path%.html}.pdf"
  local png_path="${html_path%.html}_preview.png"

  "$CHROME" --headless=new --disable-gpu --no-sandbox --no-pdf-header-footer \
    --virtual-time-budget=15000 \
    --print-to-pdf="$pdf_path" \
    "file://$html_path" 2>/dev/null

  sips -s format png "$pdf_path" --out "$png_path" >/dev/null 2>&1 || true

  echo "Rendered:"
  echo "  $pdf_path"
  echo "  $png_path"
  python3 - "$pdf_path" <<'PY'
import sys
try:
    import pypdf
except ImportError:
    print("  (pypdf not installed — skipping page-count check; run: pip install pypdf)")
    sys.exit(0)
r = pypdf.PdfReader(sys.argv[1])
n_pages = len(r.pages)
n_imgs = sum(len(p.images) for p in r.pages)
warn = "  ⚠ MULTI-PAGE — content overflowed" if n_pages > 1 else ""
print(f"  Pages: {n_pages}{warn}")
print(f"  Images embedded: {n_imgs}")
PY
}

cmd_build() {
  local company="$1" role="$2"
  if [[ "$company" == "Vanilla" ]]; then
    cmd_render "$OUTPUTS_DIR/Vanilla/CV.html"
    return
  fi
  local html_path="$OUTPUTS_DIR/$company/CV_${company}_${role}.html"
  cmd_render "$html_path"
}

cmd_status() {
  echo "All CV variants under $OUTPUTS_DIR:"
  echo ""
  printf "  %-66s %-9s %-8s %s\n" "FILE" "PAGES" "SIZE" "FLAG"
  printf "  %-66s %-9s %-8s %s\n" "----" "-----" "----" "----"

  shopt -s nullglob
  for dir in "$OUTPUTS_DIR"/*/; do
    local name
    name="$(basename "$dir")"
    case "$name" in
      _shared|_archive) continue ;;
    esac
    for pdf in "$dir"*.pdf; do
      [[ -e "$pdf" ]] || continue
      local n_pages size_kb flag rel
      n_pages="$(python3 -c "import pypdf; print(len(pypdf.PdfReader(r'''$pdf''').pages))" 2>/dev/null || echo "?")"
      size_kb=$(( $(wc -c <"$pdf") / 1024 ))
      flag=""
      [[ "$n_pages" =~ ^[0-9]+$ ]] && [[ "$n_pages" -gt 1 ]] && flag="⚠"
      rel="${pdf#$OUTPUTS_DIR/}"
      printf "  %-66s %-9s %-8s %s\n" "$rel" "$n_pages" "${size_kb} KB" "$flag"
    done
  done
  shopt -u nullglob
}

case "${1:-}" in
  new)
    [[ $# -eq 3 ]] || { usage; exit 1; }
    cmd_new "$2" "$3"
    ;;
  build)
    [[ $# -eq 3 ]] || { usage; exit 1; }
    cmd_build "$2" "$3"
    ;;
  render)
    [[ $# -eq 2 ]] || { usage; exit 1; }
    cmd_render "$2"
    ;;
  status)
    cmd_status
    ;;
  -h|--help|help|"")
    usage
    ;;
  *)
    echo "Unknown command: $1" >&2
    echo "" >&2
    usage
    exit 1
    ;;
esac
