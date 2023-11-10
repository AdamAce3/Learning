from fpdf import FPDF

class PDF(FPDF):
    def header(self):
        self.set_xy(0, 15)
        self.set_font("helvetica", "", 35)
        self.cell(0, 10, "CS50 Shirtificate", align="C")
        self.image("shirtificate.png", x = 30, y = 40, w = 150) 

pdf = PDF(orientation="P", format="A4")
pdf.add_page()
pdf.set_font("helvetica", size=20)
pdf.set_text_color(255, 255, 255)
pdf.set_xy(0, 85)
pdf.cell(0, 10, f"{input('Name: ')} took CS50", align="C")
pdf.output("shirtificate.pdf")