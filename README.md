# Simple-template-match-with-rotation
Simple template match with rotation (template crosscorrelation to the edge image of the input image
Simple template match with rotation 
Find an object that fit Template in image.The orientation of the object in the image does not have to be the same as that as the template. The template is matched to the image in various of rotations and the best match is chosen. The function use cross correlation between the template and the canny edge image of the image to determine the best match. 
MAIN_find_object_in_image (Itm,Is) is the main function. The output is the boundary and location and size of the template in the image with the object boundary marked on it. 
See the readme file supplied in the code zip file for more details.
