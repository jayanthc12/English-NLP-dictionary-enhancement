import os
import xml.etree.ElementTree as ET

# Function to read individual XML files and extract root element
def extract_root_element(xml_file):
    tree = ET.parse(xml_file)
    return tree.getroot()

# Function to combine root elements into a single XML file
def combine_elements_to_xml(elements):
    root = ET.Element('xml')
    for element in elements:
        root.append(element)
    return ET.tostring(root, encoding='unicode')

# Directory containing the input XML files
xml_directory = '/home/adarsh/Desktop/XML INPUTS'

# List all XML files in the directory
xml_files = [f for f in os.listdir(xml_directory) if f.endswith('.xml')]

# List to store all root elements
all_elements = []

# Read each XML file and extract root elements
for xml_file in xml_files:
    root_element = extract_root_element(os.path.join(xml_directory, xml_file))
    all_elements.append(root_element)

# Combine all root elements into a single XML file
combined_xml = combine_elements_to_xml(all_elements)

# Save the combined XML to a file
with open('combined.xml', 'w') as f:
    f.write(combined_xml)

print("XML files combined successfully. Output file: combined.xml")
