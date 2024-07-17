import pytesseract
import cv2
import sys
import re

def remove(string):
    return string.replace(" ", "")
     
# Driver Program
pytesseract.pytesseract.tesseract_cmd= r'C:\Program Files\Tesseract-OCR\tesseract.exe'
logArr = []
shouldBuy = False
img = cv2.imread(sys.argv[1] , 0)
img2 = cv2.imread(sys.argv[2] , 0)
img2 = cv2.resize(img2 , (200,90))
img2 = cv2.bitwise_not(img2)
text = pytesseract.image_to_string(img , config='--psm 6')
text2 = pytesseract.image_to_string(img2 , config='--psm 6')
dictx = {'24‘Hou' : 0 ,
'3H' : 0,
'5kGe' : 0,
'ear':0,
'nior': 0,
'00k':0,
'ook': 0,
'0ok': 0,
'o0k' : 0,
'50kl': 0,
'50kf': 0}

#if text.split()[2] in ['Food','Lumber','Ore'] and text.split()[1] in ['50k' , '100k' , '50K' , '100K','500k','500K']:
 #   shouldBuy = True
if 'aff' in str(''.join(text2)) and ('hund' in text or 'ind' in text or'tice' in text): # or 'telle' in text  or 'ood' in text or 'gile' in text or 'tren' in text) :
    shouldBuy = True
'''    if ''.join(text2) in dictx:
        dictx[''.join(text2)] = dictx[''.join(text2)] + 1
    else:
        dictx[''.join(text2)] = 1
for x in ['24‘Hou','3H','5kGe','ear','nior','00k','ook','0ok','o0k','50kl' , '50kf']:
    if re.search(x,remove(text),re.IGNORECASE) :
        shouldBuy = True
        dictx[x] = dictx[x] + 1
shouldBuy = str(shouldBuy)'''
z = str("Item is - " + text.strip() + ' and level is - ' + str(text2) + ' and should buy is:' + str(shouldBuy) + '\n')
with open("C:/RSL/platform-tools/tmp.txt", "a") as file_object:
    file_object.write(str(z + '::' + remove(text)))
    #file_object.write(str(dictx))
print(shouldBuy)
#print(z )



#k=input("press close to exit")
