"""import MTM
from MTM import matchTemplates
hits = matchTemplates(['Rainforest1.png'],
                      input_img,
                      score_threshold=0.9,
                      searchBox=(0, 0, 3000, 750),
                      method=cv2.TM_CCOEFF_NORMED,
                      maxOverlap=0.1)
                      """
 
""" 
import cv2
import numpy as np
from imutils.object_detection import non_max_suppression
  
# Reading the image and the template
img = cv2.imread('Rainforest1.png')
temp = cv2.imread('Yellowing-leaf.png',0)
mimg = img.copy()
  
# save the image dimensions
W, H = temp.shape[:2]
  
# Define a minimum threshold
thresh = 0.8
  
# Converting them to grayscale
img_gray = cv2.cvtColor(img, 
                        cv2.COLOR_BGR2GRAY)
cv2.imshow('Greyed',img_gray)
cv2.waitKey(0)
# Passing the image to matchTemplate method
result = cv2.matchTemplate(img_gray, temp, cv2.TM_CCORR)
min_val, max_val, min_loc, max_loc = cv2.minMaxLoc(result)
print(min_loc, max_loc)
location = min_loc
bottom_right = (location[0] + W, location[1] + H)
cv2.rectangle(mimg, location,bottom_right, 255, 5)
cv2.imshow('Modified',mimg)
cv2.imwrite('fixed.png',mimg)
cv2.waitKey(0)
cv2.destroyAllWindows() """

import cv2
import numpy as np
import sys
 
# Read the main image
img_rgb = cv2.imread(sys.argv[1])
 
# Convert it to grayscale
img_gray = cv2.cvtColor(img_rgb, cv2.COLOR_BGR2GRAY)
 
# Read the template
template = cv2.imread(sys.argv[2], 0)
 
# Store width and height of template in w and h
w, h = template.shape[::-1]
 
# Perform match operations.
res = cv2.matchTemplate(img_gray, template, cv2.TM_CCOEFF_NORMED)
 
# Specify a threshold
threshold = 0.9
 
# Store the coordinates of matched area in a numpy array
loc = np.where(res >= threshold)
 
 #Draw a rectangle around the matched region.
for pt in zip(*loc[::-1]):
    cv2.rectangle(img_rgb, pt, (pt[0] + w, pt[1] + h), (0, 255, 255), 2)
 
# Show the final image with the matched area.
img_rgb = cv2.resize(img_rgb , (480,670))
#cv2.imshow('Detected', img_rgb)
#cv2.imwrite("F:\Rallyshite\fixed.png", img_rgb)
cv2.waitKey(0)
if (len(loc[0]) == 0):
    exit()
print(min(loc[0]))