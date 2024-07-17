import pytesseract
from PIL import Image, ImageEnhance
import cv2
import sys
import re
scaleX ,scaleY = (0.75,0.75)
pytesseract.pytesseract.tesseract_cmd= r'C:\Program Files\Tesseract-OCR\tesseract.exe'
logArr = []

shouldBuy = False
img1 = cv2.imread(sys.argv[1] , 0)
#img1 = cv2.imread("F:/Shites/l41.png")

#img1 = cv2.resize(img1 , (640,250))
#enhancer = ImageEnhance.Contrast(img1)
#factor = 3.5 #increase contrast
#img1 = enhancer.enhance(factor)
#cv2.imshow('img1',img1)
#cv2.waitKey(0)
text1 = pytesseract.image_to_string(img1 , config='--psm 6')
#text2 = pytesseract.image_to_string(img2 , config='--psm 6')
print(text1.strip())