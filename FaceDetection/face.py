# -*- coding: utf-8 -*-
import os
import face_recognition as fr
import cv2
from PIL import Image, ImageDraw, ImageFilter

def cut_face(image):
    image = fr.load_image_file(image)
    face_locations = fr.face_locations(image)
     # Print the location of each face in this image
    top, right, bottom, left = face_locations[0]
    # You can access the actual face itself like this:
    face_image = image[top:bottom, left:right]
    pil_image = Image.fromarray(face_image)
    return pil_image

def frames2video(frames, video_name, play_after = False):
    # Initialize some variables
    marked_frames = []
    face_names = []
    process_this_frame = True
    known_face_encodings = ["faces\\"+img for img in os.listdir('faces')]
    current = 0
    for img in known_face_encodings:
        image = fr.load_image_file(img)
        known_face_encodings[current] = fr.face_encodings(image, fr.face_locations(image))[0]
        current += 1
    names = [img[:img.__len__()-4:] for img in os.listdir('faces')]
    for frame in frames:
        # Resize frame of video to 1/4 size for faster face recognition processing
        small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

        # Convert the image from BGR color (which OpenCV uses) to RGB color (which face_recognition uses)
        rgb_small_frame = small_frame[:, :, ::-1]

        # Only process every other frame of video to save time
        if process_this_frame:
            # Find all the faces and face encodings in the current frame of video
            face_locations = fr.face_locations(rgb_small_frame)
            face_encodings = fr.face_encodings(rgb_small_frame, face_locations)
            face_names = []
            for face_encoding in face_encodings:
                # See if the face is a match for the known face(s)
                matches = fr.compare_faces(known_face_encodings, face_encoding, 0.4)
                name = "Unknown"
                if True in matches:
                    first_match_index = matches.index(True)
                    name = names[first_match_index]

                face_names.append(name)

        process_this_frame = not process_this_frame


        # Display the results
        for (top, right, bottom, left), name in zip(face_locations, face_names):
            # Scale back up face locations since the frame we detected in was scaled to 1/4 size
            top *= 4
            right *= 4
            bottom *= 4
            left *= 4

            # Draw a box around the face
            cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)

            # Draw a label with a name below the face
            cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
            font = cv2.FONT_HERSHEY_DUPLEX
            cv2.putText(frame, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)

        marked_frames.append(frame)

    fps = 30
    height, width, layers = marked_frames[0].shape
    size = (width,height)
    out = cv2.VideoWriter(video_name, cv2.VideoWriter_fourcc(*'DIVX'), fps, size)

    for i in range(len(marked_frames)):
        # writing to a image array
        out.write(marked_frames[i])
        if play_after:
            cv2.imshow('Video', marked_frames[i])
            # Press Q on keyboard to  exit
            if cv2.waitKey(30) & 0xFF == ord('q'):
                break
    out.release()

def makeup(image):
    # Find all facial features in all the faces in the image
    face_landmarks_list = fr.face_landmarks(image)
    image = Image.fromarray(image)
    for face_landmarks in face_landmarks_list:
        d = ImageDraw.Draw(image, 'RGBA')

        # Make the eyebrows into a nightmare
        d.polygon(face_landmarks['left_eyebrow'], fill=(68, 54, 39, 128))
        d.polygon(face_landmarks['right_eyebrow'], fill=(68, 54, 39, 128))
        d.line(face_landmarks['left_eyebrow'], fill=(68, 54, 39, 150), width=5)
        d.line(face_landmarks['right_eyebrow'], fill=(68, 54, 39, 150), width=5)

        # Gloss the lips
        d.polygon(face_landmarks['top_lip'], fill=(150, 0, 0, 128))
        d.polygon(face_landmarks['bottom_lip'], fill=(150, 0, 0, 128))
        d.line(face_landmarks['top_lip'], fill=(150, 0, 0, 64), width=8)
        d.line(face_landmarks['bottom_lip'], fill=(150, 0, 0, 64), width=8)

        # Sparkle the eyes
        d.polygon(face_landmarks['left_eye'], fill=(255, 255, 255, 30))
        d.polygon(face_landmarks['ight_eye'], fill=(255, 255, 255, 30))

        # Apply some eyeliner
        d.line(face_landmarks['left_eye'] + [face_landmarks['left_eye'][0]], fill=(0, 0, 0, 110), width=6)
        d.line(face_landmarks['right_eye'] + [face_landmarks['right_eye'][0]], fill=(0, 0, 0, 110), width=6)

    return image

def blur_my_face(image):
    image = fr.load_image_file(image)
    faces = fr.face_locations(image)
    my_face = fr.load_image_file('faces\\Guy.jpg')
    my_face_location = fr.face_locations(my_face)
    my_face_encoding = fr.face_encodings(my_face, my_face_location)
    my_face_in_image_location = []
    my_face_found = False
    for face in fr.face_encodings(image, faces):
        matches = fr.compare_faces(my_face_encoding, face, 0.5)
        if True in matches:
            match_index = matches.index(True)
            my_face_in_image_location = faces[match_index]
            my_face_found = True
            break
    if my_face_found:
        top, right, bottom, left = my_face_in_image_location
        im = image[top:bottom, left:right]
        im = Image.fromarray(im)
        image = Image.fromarray(image)
        im = im.filter(ImageFilter.GaussianBlur(radius=100))
        image.paste(im, (left, top, right, bottom))
    return image

def add2faces(image, name):
    cut_face(image).save('faces\\'+name+image[image.__len__()-4::])

def face_id(known_faces, known_names, unknown_face):
    matches = []
    current = 0
    unknown_face = fr.load_image_file(unknown_face)
    unknown_face_locations = fr.face_locations(unknown_face)
    unknown_face_encoding = fr.face_encodings(unknown_face, unknown_face_locations)
    for known_face in known_faces:
        image = fr.load_image_file(known_face)
        face_locations = fr.face_locations(image)
        known_face_encoding = fr.face_encodings(image, face_locations)
        match = fr.compare_faces(known_face_encoding, unknown_face_encoding)
        if match[0]:
            matches.append(known_names[current])
        current += 1
    return matches

def video2frames(video=0):
    video_capture = cv2.VideoCapture(video)
    frames = []
    while True:
        # Grab a single frame of video
        ret, frame = video_capture.read()
    
        # Add frame to the array
        frames.append(frame)
    
        # Display the resulting image
        cv2.imshow('Video', frame)
    
        # Hit 'q' on the keyboard to quit!
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break
    
    # Release handle to the webcam
    video_capture.release()
    cv2.destroyAllWindows()
    return frames

#frames2video(video2frames(), 'video.avi', True)