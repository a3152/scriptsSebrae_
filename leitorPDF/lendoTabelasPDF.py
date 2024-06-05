import PyPDF2
import re
import pandas as pd

#Identificação do arquivo
arquivo = "001 - Daniel C. G. Ramos Consultoria em Marketing LTDA.pdf [manifesto].pdf"

# Define a regular expression to match tables
table_regex = r'(?s)\b(?:\w+\s+){2,}\w+\b(?:\s*[,;]\s*\b(?:\w+\s+){2,}\w+\b)*'

with open("S:/_CON\Monitoramento de Contratos e Convênios/CADASTRO DE CONTRATOS/CREDENCIAMENTO - SGF/CONTRATOS SGF/CONTRATOS SGF 2024/Contratos/"+arquivo, 'rb') as f:
    # Create a PDF reader object
    pdf_reader = PyPDF2.PdfReader(f)
    
    # Get the number of pages in the PDF file
    num_pages = len(pdf_reader.pages)
    
    # Loop through each page in the PDF file
    for page_num in range(num_pages):
        # Get the current page object
        page = pdf_reader.pages[page_num]
        
        # Extract the text from the current page
        page_text = page.extract_text()
        
        # Find all tables in page_text
        tables = re.findall(table_regex, page_text)
        
        #Identify tables in page_text

         # Loop through each table and create a pandas DataFrame
        for table in tables:
            # Split the table into rows
            rows = table.strip().split('\n')
            
            # Split the rows into cells
            cells = [row.split('|') for row in rows]
            
            # Remove leading and trailing whitespace from cells
            cells = [[cell.strip() for cell in row] for row in cells]
            
            # Remove empty rows and columns
            cells = [[cell for cell in row if cell] for row in cells if row]
            
            # Create a pandas DataFrame from the cells
            df = pd.DataFrame(cells[1:], columns=cells[0])


            print(df)