for file in ./*.bib; do
    [ -e "$file" ] || continue
    name=${file##*/}
    base=${name%.bib}
    pandoc --bibliography $name --filter pandoc-citeproc --csl ieee.csl bib.md -o ../layouts/shortcodes/references_$base.html
done
