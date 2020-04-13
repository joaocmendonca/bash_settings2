
gs_resize_a4 () {
	echo "This function will resize all pages of a given PDF to A4"
	file="$1"
	outfile=$(basename -s .pdf "$file")_a4.pdf
	echo "Input File: $file, Output File: $outfile"
	gs -o "$outfile" -sDEVICE=pdfwrite -sPAPERSIZE=a4 -dFIXEDMEDIA -dPDFFitPage -dCompatibilityLevel=1.4 "$file"
}


gs_reduce_pdf_quality_ebook () {

	#-dPDFSETTINGS=/screen   (screen-view-only quality, 72 dpi images)
	#-dPDFSETTINGS=/ebook    (low quality, 150 dpi images)
	#-dPDFSETTINGS=/printer  (high quality, 300 dpi images)
	#-dPDFSETTINGS=/prepress (high quality, color preserving, 300 dpi imgs)
	#-dPDFSETTINGS=/default  (almost identical to /screen)

	quality="/ebook"
	inputfile=$1
	outputfile="${inputfile%%.*}_$(echo $quality | tr -d ' /' ).pdf"

	if [[ ! -z "$1" ]]; then
		gs -q -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile="$outputfile" "$inputfile"
	else
		echo "Use gs to reduce PDF quality to $quality"
		echo "Usage: $0 Inputfile.pdf"
		echo "Output will be written to Inputfile_$(echo $quality | tr -d ' /' ).pdf"
	fi
}
