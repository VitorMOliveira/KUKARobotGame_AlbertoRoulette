from collections import Counter

from easyocr import easyocr
from flask import Flask, request, jsonify

from cv2 import cv2
import numpy as np
import base64

import calendar
import time

import pytesseract
from scipy import ndimage

app = Flask(__name__)


def calc_base(img, RobotZ):
    global pix_X, pix_Y, desv_X, desv_Y

    img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    HSV_MIN_CENTER = (240 / 2, 15 * 255 / 100, 20 * 255 / 100)
    HSV_MAX_CENTER = (300 / 2, 40 * 255 / 100, 60 * 255 / 100)

    mask_center = cv2.inRange(img_hsv, HSV_MIN_CENTER, HSV_MAX_CENTER)
    kernel = np.ones((3, 3), np.uint8)
    mask_center = cv2.erode(mask_center, kernel, iterations=1)
    mask_center = cv2.dilate(mask_center, kernel, iterations=1)
    kernel = np.ones((9, 9), np.uint8)
    mask_center = cv2.dilate(mask_center, kernel, iterations=2)
    mask_center = cv2.erode(mask_center, kernel, iterations=2)
    blur_k = 3
    mask_center = cv2.medianBlur(mask_center, blur_k)

    cv2.imwrite("mask_center.png", mask_center)

    minC, maxC = 20, 70

    ball_mm = 22
    pix_X = np.round(ball_mm / 75, 4)
    pix_Y = np.round(ball_mm / 78, 4)

    if RobotZ == "Z_100":
        minC, maxC = 60, 85
        pix_X = np.round(ball_mm / 145, 4)
        pix_Y = np.round(ball_mm / 148, 4)

    circle_center = cv2.HoughCircles(mask_center, cv2.HOUGH_GRADIENT,
                                     1, 300, param1=50, param2=11, minRadius=minC, maxRadius=maxC)

    print(circle_center)
    img_circles = img.copy()

    cX = np.uint16(img.shape[1] / 2)
    cY = np.uint16(img.shape[0] / 2)
    cv2.circle(img_circles, (cX, cY), 12, (0, 0, 255), 3)

    circle_center = np.uint16(np.around(circle_center))

    for i in circle_center[0, :]:
        # draw the outer circle
        cv2.circle(img_circles, (i[0], i[1]), i[2], (0, 255, 0), 2)
        # draw the center of the circle
        cv2.circle(img_circles, (i[0], i[1]), 2, (0, 0, 255), 3)

    cv2.imwrite("img_center.png", img_circles)

    image_file = "img_center.png"
    # convert img to base64
    with open(image_file, "rb") as f:
        im_bytes = f.read()
    im_b64 = base64.b64encode(im_bytes).decode("utf8")

    if circle_center is None:
        print("ERROR :: DIDN'T FOUND CUPS ")
        return 0, 0
    else:
        if circle_center[0].shape[0] > 1:
            print("WARNING:: DETECT MORE THAN ONE CUP!!")

        center = np.round(circle_center[0][0])

    print("\ncenter roulette coords: " + str(center[0]) + "," + str(center[1]))

    # CALCULAR DISTÂNCIA DO CENTRO DA IMAGEM (PERTO DO GRIPPER) ao primeiro cup

    # calcular desvio de pixeis do centro da imagem à bola central #
    image_center_X = img.shape[1] / 2
    image_center_Y = img.shape[0] / 2

    print("\nimage center: " + str(image_center_X) + "," + str(image_center_Y))

    desv_center_X = center[0] - image_center_X
    desv_center_Y = center[1] - image_center_Y

    print("\nimage center -> center ball in X distance: " + str(desv_center_X) + " pix")
    print("image center -> center ball in Y distance: " + str(desv_center_Y) + " pix")

    print("\npixel X in millimeters: " + str(pix_X) + " mm")
    print("pixel Y in millimeters: " + str(pix_Y) + " mm")

    desv_X = np.round(desv_center_X * pix_X, 6)
    desv_Y = np.round(desv_center_Y * pix_Y, 6)

    print("\ndesv X in millimeters: " + str(desv_X) + " mm")
    print("desv Y in millimeters: " + str(desv_Y) + " mm")

    # calculate angle
    angle = 0
    if RobotZ == "Z_100":
        HSV_MIN_ANGLE = (85 / 2, 15 * 255 / 100, 60 * 255 / 100)
        HSV_MAX_ANGLE = (115 / 2, 40 * 255 / 100, 90 * 255 / 100)

        mask_angle = cv2.inRange(img_hsv, HSV_MIN_ANGLE, HSV_MAX_ANGLE)
        kernel = np.ones((3, 3), np.uint8)
        mask_angle = cv2.erode(mask_angle, kernel, iterations=2)
        mask_angle = cv2.dilate(mask_angle, kernel, iterations=2)
        kernel = np.ones((7, 7), np.uint8)
        mask_angle = cv2.dilate(mask_angle, kernel, iterations=2)
        mask_angle = cv2.erode(mask_angle, kernel, iterations=2)
        blur_k = 5
        mask_angle = cv2.medianBlur(mask_angle, blur_k)

        cv2.imwrite("mask_angle.png", mask_angle)

        circle_angle = cv2.HoughCircles(mask_angle, cv2.HOUGH_GRADIENT,
                                        1, 300, param1=50, param2=12, minRadius=60, maxRadius=90)

        print(circle_angle)
        cAngle = np.round(circle_angle[0][0])
        vec_AX = center[:-1] - cAngle[:-1]

        circle_angle = np.uint16(np.around(circle_angle))
        img_angle = img_circles.copy()

        for i in circle_angle[0, :]:
            # draw the outer circle
            cv2.circle(img_angle, (i[0], i[1]), i[2], (0, 255, 0), 2)
            # draw the center of the circle
            cv2.circle(img_angle, (i[0], i[1]), 2, (0, 0, 255), 3)

        cv2.imwrite("img_angle.png", img_angle)

        image_file = "img_angle.png"
        # convert img to base64
        with open(image_file, "rb") as f:
            im_bytes = f.read()
        im_b64 = base64.b64encode(im_bytes).decode("utf8")

        # vetor imaginário horizontal do central
        vec_AI = (center[:-1] - [100, 0]) - center[:-1]

        ang1 = np.arctan2(*vec_AX[::-1])
        ang2 = np.arctan2(*vec_AI[::-1])
        angle = np.rad2deg((ang2 - ang1) % (2 * np.pi))
        angle = np.round(angle, 6)

        print("angle in degrees: " + str(angle))

    return desv_X, (desv_Y * -1), angle, im_b64


def Detect_Blue_Ball(img):
    blur_k = 11
    t = img.copy()
    img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    HSV_MIN_BLUE_BALL = (140 / 2, 10 * 255 / 100, 30 * 255 / 100)
    HSV_MAX_BLUE_BALL = (220 / 2, 70 * 255 / 100, 100 * 255 / 100)

    mask_blue_ball = cv2.inRange(img_hsv, HSV_MIN_BLUE_BALL, HSV_MAX_BLUE_BALL)

    cv2.imwrite("mask_blue_ball_small.png", mask_blue_ball)

    # remove small blobs
    kernel = np.ones((5, 5), np.uint8)
    mask = cv2.erode(mask_blue_ball, kernel, iterations=2)
    mask = cv2.dilate(mask, kernel, iterations=2)
    mask = cv2.medianBlur(mask, blur_k)

    min_dist_blue = 300
    min_area_blue = 15
    max_area_blue = 35

    circle_blue = cv2.HoughCircles(mask, cv2.HOUGH_GRADIENT, 1, min_dist_blue, param1=50, param2=11,
                                   minRadius=min_area_blue, maxRadius=max_area_blue)

    circle_blue = np.uint16(np.around(circle_blue))

    blob_x_blue = int(circle_blue[0][0][0])
    blob_y_blue = int(circle_blue[0][0][1])
    print("Center of blue blob:", blob_x_blue, ",", blob_y_blue, "with radius:", circle_blue[0][0][2])

    if len(circle_blue) != 1:
        print("DETECTED MORE THAN ONE BLOB!!!")

    # signal all circles detected in original img
    img_circles = img.copy()

    for j in circle_blue[0, :]:
        # draw the outer circle
        cv2.circle(img_circles, (j[0], j[1]), j[2], (0, 255, 0), 2)
        # draw the center of the circle
        cv2.circle(img_circles, (j[0], j[1]), 2, (0, 0, 255), 3)

    cv2.imwrite("img_circles_small.png", img_circles)

    return circle_blue, blob_x_blue, blob_y_blue


def calc_distMagnet(img):
    circle_blue, blob_x_blue, blob_y_blue = Detect_Blue_Ball(img)

    if circle_blue is None:
        print("ERROR: DIDN'T FOUND IMAN BALL!!")
        return 0, 0

    else:
        # calcular desvio de pixeis do centro da imagem à bola central #
        image_center_X = img.shape[1] / 2
        image_center_Y = img.shape[0] / 2

        print("\nimage center: " + str(image_center_X) + "," + str(image_center_Y))

        desv_mini_ball_X = blob_x_blue - image_center_X
        desv_mini_ball_Y = blob_y_blue - image_center_Y

        print("\ndistance X,Y from green ball to center image: " + str(desv_mini_ball_X) + "," + str(
            desv_mini_ball_Y))

        print("\npixel X in millimeters: " + str(pix_X) + " mm")
        print("pixel Y in millimeters: " + str(pix_Y) + " mm")

        dist_X = np.round(desv_mini_ball_X * pix_X, 1)
        dist_Y = np.round(desv_mini_ball_Y * pix_Y, 1)

        adjX = dist_X + 3
        adjY = (dist_Y * -1) + 72

        print("Dist X mini ball in millimeters: " + str(adjX) + " mm")
        print("Dist Y mini ball in millimeters: " + str(adjY) + " mm")

    return adjX, adjY


def rotate_image(img_ball, blob_x, blob_y):
    center_img_x = int(img_ball.shape[1] / 2)
    center_img_y = int(img_ball.shape[0] / 2)

    vector_CB = [blob_x - center_img_x, blob_y - center_img_y]
    vector_CC = [center_img_x - center_img_x, (center_img_y - 100) - center_img_y]

    unit_vector_CB = vector_CB / np.linalg.norm(vector_CB)
    unit_vector_CC = vector_CC / np.linalg.norm(vector_CC)

    dot_product = np.dot(unit_vector_CB, unit_vector_CC)
    angle_rad = np.arccos(dot_product)
    angle_deg = np.round(np.degrees(angle_rad), 1)

    if blob_x >= center_img_x:
        angle_deg = angle_deg
    else:
        angle_deg = - angle_deg

    imgR = ndimage.rotate(img_ball, angle_deg, reshape=False)

    return imgR, angle_deg


def crop_image(blob_x, blob_y, w_blob_up, w_blob_low, h_blob_up, h_blob_low, img):
    y_min, y_max, x_min, x_max = blob_y - h_blob_up, blob_y + h_blob_low, blob_x - w_blob_low, blob_x + w_blob_up

    # guarantees that doesnt overflow image boundaries
    if y_min < 0: y_min = 0
    if y_max > img.shape[0]: y_max = img.shape[0]
    if x_min < 0: x_min = 0
    if x_max > img.shape[1]: x_max = img.shape[0]
    if blob_x > -1 and blob_y > -1:
        crop_img = img[y_min:y_max, x_min:x_max]

    return crop_img


def recognize_text(img_path):
    '''loads an image and recognizes text.'''
    reader = easyocr.Reader(['en'])

    return reader.readtext(img_path, allowlist='0123456789')

def sharpen(image):
    kernel = np.array([[-1, -1, -1], [-1, 9, -1], [-1, -1, -1]])
    # kernel = np.array([[0, -1, 0], [-1, 5,-1], [0, -1, 0]])
    return cv2.filter2D(image, -1, kernel)


def Detect_OCR(img):
    prob = 0
    # Detect Blue ball
    circle_blue, blob_x_blue, blob_y_blue = Detect_Blue_Ball(img)

    # Calculate the angle and rotate the image
    imgR, angle_deg = rotate_image(img, blob_x_blue, blob_y_blue)

    # Detect blue ball in new image R
    circle_blue1, blob_x_blue1, blob_y_blue1 = Detect_Blue_Ball(imgR)

    # Crop the image R1
    w_blob2_up, w_blob2_low, h_blob2_up, h_blob2_low = 34, 34, 180, -30
    crop_img = crop_image(blob_x_blue1, blob_y_blue1, w_blob2_up, w_blob2_low, h_blob2_up, h_blob2_low, imgR)

    kernel = np.ones((5, 5), np.uint8)
    crop_img = cv2.erode(crop_img, kernel)
    crop_img = sharpen(crop_img)
    crop_img = cv2.GaussianBlur(crop_img, (0, 0), 2)

    cv2.imwrite("img_crop_number.png", crop_img)

    image_file = "img_crop_number.png"
    # convert img to base64
    with open(image_file, "rb") as f:
        im_bytes = f.read()
    im_b64 = base64.b64encode(im_bytes).decode("utf8")


    # Detect number in crop image
    reader = easyocr.Reader(['en'])
    result = reader.readtext(crop_img, allowlist='0123456789')
    number = pytesseract.image_to_string(crop_img, config=custom_config)

    if len(result) != 0:
        prob = result[0][2]
        if number.rstrip("\n") == result[0][1]:
            prob = 0.99
    if number != "":
        numbers_pytesseract.append(number.rstrip("\n"))

    angle_deg1_inc = 0
    angle_deg1_dec = 0
    i = 0
    imgR1 = imgR
    while prob < 0.95:
        angle_deg1_inc = angle_deg1_inc + 0.55
        if angle_deg1_inc > 2.4:
            i = i + 1
            angle_deg1_dec = angle_deg1_dec - 0.55
            imgR1 = ndimage.rotate(imgR1, angle_deg1_dec)
            circle_blue1, blob_x_blue1, blob_y_blue1 = Detect_Blue_Ball(imgR1)
            crop_img2 = crop_image(blob_x_blue1, blob_y_blue1, w_blob2_up, w_blob2_low, h_blob2_up, h_blob2_low, imgR1)
            crop_img2 = cv2.erode(crop_img2, kernel)
            crop_img2 = sharpen(crop_img2)
            crop_img2 = cv2.GaussianBlur(crop_img2, (0, 0), 2)

            result = recognize_text(crop_img2)
            number = pytesseract.image_to_string(crop_img2, config=custom_config)

            if len(result) != 0:
                prob = result[0][2]
                if number.rstrip("\n") == result[0][1]:
                    prob = 0.99
            if number != "":
                numbers_pytesseract.append(number.rstrip("\n"))

        if angle_deg1_inc <= 2.4:
            i = i + 1
            imgR1 = ndimage.rotate(img, angle_deg1_inc)
            circle_blue1, blob_x_blue1, blob_y_blue1 = Detect_Blue_Ball(imgR1)
            crop_img2 = crop_image(blob_x_blue1, blob_y_blue1, w_blob2_up, w_blob2_low, h_blob2_up, h_blob2_low, imgR1)
            crop_img2 = cv2.erode(crop_img2, kernel)
            crop_img2 = sharpen(crop_img2)
            crop_img2 = cv2.GaussianBlur(crop_img2, (0, 0), 2)

            result = recognize_text(crop_img2)
            number = pytesseract.image_to_string(crop_img2, config=custom_config)

            if len(result) != 0:
                prob = result[0][2]
                if number.rstrip("\n") == result[0][1]:
                    prob = 0.99
            if number != "":
                numbers_pytesseract.append(number.rstrip("\n"))

        if angle_deg1_inc >= 4.6:
            break

    counter = Counter(numbers_pytesseract)

    if prob > 0.95:
        if len(result[0][1]) == 3:
            number = result[0][1]
            if ((number[0] == '1' and number[2] != '1' and (
                    number[1] == '1' or number[1] == '2' or number[1] == '3')) or number[0] == '7' and number[
                2] != '1'):
                number = number.replace(number[0], "")
            else:
                number = number.replace(number[2], "")
        else:
            number = result[0][1]
        print("number :: " + number)
        return number, im_b64
    elif len(counter) != 0:
        number = max(counter, key=counter.get)
        print("number :: " + number)
        return number, im_b64
    else:
        print("number fixed :: " + str(0))
        return int(0), im_b64

def Distribution_Cups(cupPos, photoHeight, img):
    img_hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

    print("cupPos " + str(cupPos))
    # PLAYER 4 - green
    if 13 <= cupPos <= 16:
        print("green ")
        HSV_MIN_RECTANGLE = (80 / 2, 20 * 255 / 100, 25 * 255 / 100)
        HSV_MAX_RECTANGLE = (120 / 2, 80 * 255 / 100, 60 * 255 / 100)

    # PLAYER 1 - blue
    elif 1 <= cupPos <= 4:
        print("blue ")
        HSV_MIN_RECTANGLE = (190 / 2, 40 * 255 / 100, 40 * 255 / 100)
        HSV_MAX_RECTANGLE = (220 / 2, 70 * 255 / 100, 100 * 255 / 100)

    # PLAYER 3 - pink
    elif 5 <= cupPos <= 8:
        print("pink ")
        HSV_MIN_RECTANGLE = (320 / 2, 15 * 255 / 100, 65 * 255 / 100)
        HSV_MAX_RECTANGLE = (352 / 2, 70 * 255 / 100, 100 * 255 / 100)

    # PLAYER 2 - orange
    elif 9 <= cupPos <= 12:
        print("orange ")
        HSV_MIN_RECTANGLE = (3 / 2, 35 * 255 / 100, 60 * 255 / 100)
        HSV_MAX_RECTANGLE = (30 / 2, 80 * 255 / 100, 90 * 255 / 100)
    else:
        print("none color ")

    mask_rectangle = cv2.inRange(img_hsv, HSV_MIN_RECTANGLE, HSV_MAX_RECTANGLE)

    kernel = np.ones((9, 9), np.uint8)
    mask_rectangle = cv2.dilate(mask_rectangle, kernel, iterations=2)
    mask_rectangle = cv2.erode(mask_rectangle, kernel, iterations=2)
    blur_k = 5
    mask_rectangle = cv2.medianBlur(mask_rectangle, blur_k)

    cv2.imwrite("mask_rectangle.png", mask_rectangle)

    minR, maxR = 20, 70
    if photoHeight == "low":
        minR, maxR = 60, 200

    circle = cv2.HoughCircles(mask_rectangle, cv2.HOUGH_GRADIENT, 1, 100, param1=50, param2=11,
                              minRadius=minR, maxRadius=maxR)

    circles = np.uint16(np.around(circle))

    x = int(circles[0][0][0])
    y = int(circles[0][0][1])
    print("Center of cup delivery:", x, ",", y, "with radius:", circles[0][0][2])

    res_img = img.copy()
    # draw the outer circle
    cv2.circle(res_img, (x, y), circles[0][0][2], (0, 255, 0), 2)
    # draw the center of the circle
    cv2.circle(res_img, (x, y), 2, (0, 0, 255), 3)

    cv2.imwrite("cup_delivery.png", res_img)

    # calcular desvio de pixeis do centro da imagem à bola central #
    image_center_X = img.shape[1] / 2
    image_center_Y = img.shape[0] / 2

    desv_deliver_X = x - image_center_X
    desv_deliver_Y = y - image_center_Y
    print("\ndistance X,Y from deliver to img center: " + str(desv_deliver_X) + "," + str(desv_deliver_Y))

    # tirar medida de X,Y da esfera central em mm e depois na foto ver o seu valor em pixeis
    pix_X1 = np.round(55.10 / 112, 4)
    pix_Y1 = np.round(55.10 / 112, 4)

    if photoHeight == "low":
        pix_X1 = np.round(55.10 / 289, 4)
        pix_Y1 = np.round(55.10 / 290, 4)

    print("\npixel X,Y in millimeters: " + str(pix_X1) + ", " + str(pix_Y1))

    dist_X = np.round(desv_deliver_X * pix_X1, 3)
    dist_Y = np.round(desv_deliver_Y * pix_Y1, 3)

    adjX = dist_X
    adjY = dist_Y*-1

    print("Dist X deliver: " + str(adjX) + " mm")
    print("Dist Y deliver: " + str(adjY) + " mm")

    return adjX, adjY


@app.route('/post_roulette_img', methods=['POST'])
def process_roulette_image():
    global getImage

    content = request.get_json()

    base64Img = content['img']
    doOCR = content['do_ocr']

    image_64_decode = base64.b64decode(base64Img)
    image_result = open('qt_roulette_img.png', 'wb')  # create a writable image and write the decoding result

    image_result.write(image_64_decode)

    img = cv2.imread("qt_roulette_img.png")
    print("qt_roulette_img shape: ", img.shape)

    # gmt stores current gmtime
    gmt = time.gmtime()
    # ts stores timestamp
    ts = calendar.timegm(gmt)
    print("timestamp:-", ts)

    cv2.imwrite("roulette_numbers//numbers_05_03_" + str(ts) + ".png", img)

    offsetX_MagnetBall, offsetY_MagnetBall = calc_distMagnet(img)

    image_file = "img_circles_small.png"
    # convert img to base64
    with open(image_file, "rb") as f:
        im_bytes = f.read()
    im_b64 = base64.b64encode(im_bytes).decode("utf8")

    pred_number = -1

    if doOCR == "yes_ocr":
        pred_number, im_b64 = Detect_OCR(img)
    else:
        print("OCR IS NOT ENABLED!!!!")

    res = {'IMG': im_b64,
           'X_OFFSET_MAGNETBALL': str(offsetX_MagnetBall),
           'Y_OFFSET_MAGNETBALL': str(offsetY_MagnetBall),
           'PRED_NUMBER': str(pred_number)
           }

    return jsonify(res)


@app.route('/post_calibrate_img', methods=['POST'])
def process_calibrate_image():
    content = request.get_json()

    base64Img = content['img']
    RobotZ = content['type']

    image_64_decode = base64.b64decode(base64Img)
    image_result = open('qt_calibrate_img.png', 'wb')  # create a writable image and write the decoding result
    image_result.write(image_64_decode)

    img = cv2.imread("qt_calibrate_img.png")
    print("qt_calibrate_img shape: ", img.shape)

    # gmt stores current gmtime
    gmt = time.gmtime()
    # ts stores timestamp
    ts = calendar.timegm(gmt)
    print("timestamp:-", ts)

    cv2.imwrite("calibrate_imgs//qt_calibrate_v2_" + str(ts) + ".png", img)
    offsetX, offsetY, angle, im_b64 = calc_base(img, RobotZ)

    # output
    res = {'IMG': im_b64,
           'X_OFFSET': str(offsetX),
           'Y_OFFSET': str(offsetY),
           'ANGLE_OFFSET': str(angle)
           }
    return jsonify(res)


@app.route('/post_cups_img', methods=['POST'])
def process_cups_image():
    global getImage

    content = request.get_json()

    base64Img = content['img']
    cupPos = content['cup_pos']
    photoHeight = content['photo_height']

    image_64_decode = base64.b64decode(base64Img)
    image_result = open('qt_cups_img.png', 'wb')  # create a writable image and write the decoding result

    image_result.write(image_64_decode)

    img = cv2.imread("qt_cups_img.png")
    print("qt_cups_img shape: ", img.shape)

    # gmt stores current gmtime
    gmt = time.gmtime()
    # ts stores timestamp
    ts = calendar.timegm(gmt)
    print("timestamp:-", ts)

    cv2.imwrite("cups_imgs//qt_cups_" + str(ts) + ".png", img)

    X, Y = Distribution_Cups(int(cupPos), photoHeight, img)

    image_file = "cup_delivery.png"
    # convert img to base64
    with open(image_file, "rb") as f:
        im_bytes = f.read()
    im_b64 = base64.b64encode(im_bytes).decode("utf8")

    res = {'IMG': im_b64,
           'X_OFFSET_DELIVER': str(X),
           'Y_OFFSET_DELIVER': str(Y)
           }

    return jsonify(res)


if __name__ == '__main__':
    global getImage, pix_X, pix_Y, desv_X, desv_Y
    getImage = np.zeros((1000, 1000))

    pix_X, pix_Y = 0, 0

    pytesseract.pytesseract.tesseract_cmd = r"C:\Programs\Tesseract-OCR\tesseract.exe"
    custom_config = r'--oem 1 --psm 11 outputbase digits'
    numbers_pytesseract = []

    app.run(host='localhost', port=9000, debug=True, use_reloader=False)
