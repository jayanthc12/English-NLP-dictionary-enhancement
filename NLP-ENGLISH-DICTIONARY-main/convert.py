import xml.etree.ElementTree as ET

def clean_text_element(text_element):
    text_element.tag = "text"
    text_element.attrib.clear()

def extract_title_text(input_path, output_path):
    tree = ET.parse(input_path)
    root = tree.getroot()

    output_root = ET.Element("xml")

    for page in root.findall("./page"):
        title_element = page.find("title")
        text_element = page.find("revision/text")

        if title_element is not None and text_element is not None:
            clean_text_element(text_element)

            output_page = ET.SubElement(output_root, "page")
            titlexml=ET.SubElement(output_page,"title")
            titlexml.text=title_element.text
            textxml=ET.SubElement(output_page,"text")
            textxml.text=text_element.text

    output_tree = ET.ElementTree(output_root)
    output_tree.write(output_path)

if __name__ == "__main__":
    input_path = "/home/adarsh/Desktop/NLP-ENGLISH-DICTIONARY/combined.xml"
    output_path = "ansx.xml"
    extract_title_text(input_path, output_path)



# import os
# import xml.etree.ElementTree as ET

# # Function to read individual XML files and extract root element
# def extract_root_element(xml_file):
#     tree = ET.parse(xml_file)
#     return tree.getroot()   

# # Function to combine root elements into a single XML file
# def combine_elements_to_xml(elements):
#     root = ET.Element('xml')
#     for element in elements:
#         root.append(element)
#     return ET.tostring(root, encoding='unicode')

# # Directory containing the input XML files
# xml_directory = '/home/adarsh/Desktop/NLP-ENGLISH-DICTIONARY/analyzers/afterlang/input/x/x_0'

# # List all XML files in the directory
# xml_files = [f for f in os.listdir(xml_directory) if f.endswith('.xml')]

# # List to store all root elements
# all_elements = []

# # Read each XML file and extract root elements
# for xml_file in xml_files:
#     root_element = extract_root_element(os.path.join(xml_directory, xml_file))
#     all_elements.append(root_element)

# # Combine all root elements into a single XML file
# combined_xml = combine_elements_to_xml(all_elements)

# # Save the combined XML to a file
# with open('combined.xml', 'w') as f:
#     f.write(combined_xml)

# print("XML files combined successfully. Output file: combined.xml")