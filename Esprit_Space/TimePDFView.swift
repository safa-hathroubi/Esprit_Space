//
//  TimePDFView.swift
//  Esprit_Space
//
//  Created by Emna Ouenniche on 17/04/2023.
//

import SwiftUI
import PDFKit



struct TimePDFView_Previews: PreviewProvider {
    static var previews: some View {
        TimePDFView()
    }
}


struct TimePDFView: View {
    var body: some View {
        PDFViewWrapper(url: URL(fileURLWithPath: "/Users/emnaouenniche/Desktop/Esprit_Space 3/3iL_cycle_Ingénieurs" ))
            .frame(width: 100, height: 300)
    }
}




struct PDFViewWrapper: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = PDFDocument(url: url)
        pdfView.autoScales = true
        pdfView.backgroundColor = .red

        return pdfView
    }

    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = PDFDocument(url: url)
    }
}


