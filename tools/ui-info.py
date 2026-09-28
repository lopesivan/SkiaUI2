import xml.etree.ElementTree as ET

tree = ET.parse('/tmp/ui.xml')
for node in tree.iter():
    bounds = node.get('bounds', '')
    text   = node.get('text', '')
    cls    = node.get('class', '').split('.')[-1]
    desc   = node.get('content-desc', '')
    if bounds and (text or desc):
        print(f'{bounds:30s} {cls:20s} {text or desc}')
