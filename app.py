from logging import debug
from flask import Flask, render_template,jsonify,request, redirect, url_for, session
import cv2
from PIL import Image
from io import BytesIO
import numpy as np
from matplotlib import pyplot as plt
import mysql.connector
import tensorflow as tf
from tensorflow import keras
import uuid


app = Flask(__name__)

app.secret_key="ancal"

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="ancal"
)


model = keras.models.load_model("model-demo")
modelCowOrNot = keras.models.load_model("CowOrNot")

# defining the canny detector function
  
# here weak_th and strong_th are thresholds for
# double thresholding step
def Canny_detector(img, weak_th = None, strong_th = None):

     
    # conversion of image to grayscale
    img = cv2.cvtColor(np.float32(img), cv2.COLOR_BGR2GRAY)
      
    # Noise reduction step
    img = cv2.GaussianBlur(img, (5, 5), 1.4)
      
    # Calculating the gradients
    gx = cv2.Sobel(np.float32(img), cv2.CV_64F, 1, 0, 3)
    gy = cv2.Sobel(np.float32(img), cv2.CV_64F, 0, 1, 3)
     
    # Conversion of Cartesian coordinates to polar
    mag, ang = cv2.cartToPolar(gx, gy, angleInDegrees = True)
      
    # setting the minimum and maximum thresholds
    # for double thresholding
    mag_max = np.max(mag)
    if not weak_th:weak_th = mag_max * 0.1
    if not strong_th:strong_th = mag_max * 0.5
     
    # getting the dimensions of the input image 
    height, width = img.shape
      
    # Looping through every pixel of the grayscale
    # image
    for i_x in range(width):
        for i_y in range(height):
              
            grad_ang = ang[i_y, i_x]
            grad_ang = abs(grad_ang-180) if abs(grad_ang)>180 else abs(grad_ang)
              
            # selecting the neighbours of the target pixel
            # according to the gradient direction
            # In the x axis direction
            if grad_ang<= 22.5:
                neighb_1_x, neighb_1_y = i_x-1, i_y
                neighb_2_x, neighb_2_y = i_x + 1, i_y
             
            # top right (diagonal-1) direction
            elif grad_ang>22.5 and grad_ang<=(22.5 + 45):
                neighb_1_x, neighb_1_y = i_x-1, i_y-1
                neighb_2_x, neighb_2_y = i_x + 1, i_y + 1
             
            # In y-axis direction
            elif grad_ang>(22.5 + 45) and grad_ang<=(22.5 + 90):
                neighb_1_x, neighb_1_y = i_x, i_y-1
                neighb_2_x, neighb_2_y = i_x, i_y + 1
             
            # top left (diagonal-2) direction
            elif grad_ang>(22.5 + 90) and grad_ang<=(22.5 + 135):
                neighb_1_x, neighb_1_y = i_x-1, i_y + 1
                neighb_2_x, neighb_2_y = i_x + 1, i_y-1
             
            # Now it restarts the cycle
            elif grad_ang>(22.5 + 135) and grad_ang<=(22.5 + 180):
                neighb_1_x, neighb_1_y = i_x-1, i_y
                neighb_2_x, neighb_2_y = i_x + 1, i_y
              
            # Non-maximum suppression step
            if width>neighb_1_x>= 0 and height>neighb_1_y>= 0:
                if mag[i_y, i_x]<mag[neighb_1_y, neighb_1_x]:
                    mag[i_y, i_x]= 0
                    continue
  
            if width>neighb_2_x>= 0 and height>neighb_2_y>= 0:
                if mag[i_y, i_x]<mag[neighb_2_y, neighb_2_x]:
                    mag[i_y, i_x]= 0
  
    weak_ids = np.zeros_like(img)
    strong_ids = np.zeros_like(img)             
    ids = np.zeros_like(img)
      
    # double thresholding step
    for i_x in range(width):
        for i_y in range(height):
             
            grad_mag = mag[i_y, i_x]
             
            if grad_mag<weak_th:
                mag[i_y, i_x]= 0
            elif strong_th>grad_mag>= weak_th:
                ids[i_y, i_x]= 1
            else:
                ids[i_y, i_x]= 2
      
      
    # finally returning the magnitude of
    # gradients of edges
    return mag

class_names = ['Sapi Aceh', 'Sapi Angus', 'Sapi Bali', 'Sapi Brahman', 'Sapi Limousin', 'Sapi Madura', 'Sapi Ongole', 'Sapi Simental']
class_names_ayam = ['Pejantan Busuk','Pejantan Kurang Segar','Pejantan Segar','Kampung Busuk','Kampung Kurang Segar','Kampung Segar']

####### API ROUTE #######


# @app.route("/debug")
# def debug():
#     sunflower_url = "https://storage.googleapis.com/download.tensorflow.org/example_images/592px-Red_sunflower.jpg"
#     sunflower_path = tf.keras.utils.get_file('Red_sunflower', origin=sunflower_url)

#     img = keras.preprocessing.image.load_img(
#         sunflower_path, target_size=(180, 180)
#     )
#     img_array = keras.preprocessing.image.img_to_array(img)
#     img_array = tf.expand_dims(img_array, 0) # Create a batch

#     predictions = model.predict(img_array)
#     score = tf.nn.softmax(predictions[0])

#     print(
#     "This image most likely belongs to {} with a {:.2f} percent confidence.".format(class_names[np.argmax(score)], 100 * np.max(score)))

#     return "123"


@app.route("/api/register", methods=["POST"])
def register_api():
    nama = request.form["nama"]
    email = request.form["email"]
    password = request.form["password"]

    mydb.connect()

    cursor = mydb.cursor()

    cursor.execute("SELECT * FROM user WHERE email=%s",(email,))

    exist = cursor.fetchone()

    if exist is not None:
        cursor.close()
        mydb.close()
        return jsonify({
            "success":False,
            "msg":"Duplicate email"
        })
    else:
        cursor.execute("INSERT INTO user VALUES (NULL,%s,%s,%s)",(nama,email,password))

        mydb.commit()

        cursor.close()
        mydb.close()


        return jsonify({
            "success":True,
            "data":{
                "id_user":cursor.lastrowid,
                "nama":nama,
                "email":email,
                "password":password,
            }
        })


@app.route("/api/login", methods=["POST"])
def login_api():
    email = request.form["email"]
    password = request.form["password"]


    mydb.connect()

    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM user WHERE email=%s",(email,))

    row = cursor.fetchone()

    cursor.close()
    mydb.close()

    if row==None:
            return jsonify({
                "success":False,
                "msg":"User not found"
            })

    e = row[2]
    p = row[3]


    if e==email and p==password:
        session["login"]=True
        return jsonify({
            "success":True,
            "data":{
                "id_user":row[0],
                "nama":row[1],
                "email":row[2],
                "password":row[3]
            }
        })
    else:
        return jsonify({
            "success":False,
            "msg":"Invalid password"
        })


#########################

@app.route("/logout")
def logout():
    session.pop("login")
    return redirect(url_for("login"))


@app.route("/",methods=["POST","GET"])
def login():

    if 'login' in session:
        return redirect(url_for("dashboard"))

    if request.method=="POST":
        email = request.form["email"]
        password = request.form["password"]

        mydb.connect()

        cursor = mydb.cursor()
        cursor.execute("SELECT * FROM admin WHERE email=%s",(email,))

        row = cursor.fetchone()

        cursor.close()
        mydb.close()

        if row==None:
             return render_template("login.html",msg="Tidak ditemukan user tersebut")

        e = row[1]
        p = row[2]

        if e==email and p==password:
            session["login"]=True
            return redirect(url_for("dashboard"))
        else:
            return render_template("login.html",msg="Password yang dimasukkan salah")
        
    
    return render_template("login.html")

@app.route("/dashboard")
def dashboard():

    if 'login' not in session:
        return redirect(url_for("login"))

    return render_template("dashboard.html")

################ USER ROUTE #######################

@app.route("/user")
def user():

    if 'login' not in session:
        return redirect(url_for("login"))

    mydb.connect()
    cursor = mydb.cursor()

    cursor.execute("SELECT * FROM user")
    rows = cursor.fetchall()

    cursor.close()
    mydb.close()

    return render_template("user.html", rows=rows)
@app.route("/user/create", methods=["POST","GET"])
def create_user():

    if 'login' not in session:
        return redirect(url_for("login"))

    if(request.method=="POST"):
        nama = request.form["nama"]
        email = request.form["email"]
        password = request.form["password"]

        mydb.connect()
        cursor = mydb.cursor()

        cursor.execute("INSERT INTO user VALUES (NULL,%s,%s,%s)",(nama,email,password))

        mydb.commit()
        cursor.close()
        mydb.close()

        return redirect(url_for("user"))
    return render_template("user:tambah.html")
@app.route("/user/update/<id>", methods=["GET","POST"])
def update_user(id):

    if 'login' not in session:
        return redirect(url_for("login"))


    if(request.method=="POST"):
        nama = request.form["nama"]
        email = request.form["email"]
        password = request.form["password"]

        mydb.connect()
        cursor = mydb.cursor()

        cursor.execute("UPDATE user SET nama=%s,email=%s,password=%s WHERE id_user=%s",(nama,email,password,id))

        mydb.commit()
        cursor.close()
        mydb.close()

        return redirect(url_for("user"))

    mydb.connect()
    cursor = mydb.cursor()

    cursor.execute("SELECT * FROM user WHERE id_user=%s",(id,))
    rows = cursor.fetchone()

    if(rows==None):
        return redirect(url_for("user"))

    cursor.close()
    mydb.close()


    return render_template("user:update.html", rows=rows)
@app.route("/user/delete/<id>")
def delete_user(id):

    if 'login' not in session:
        return redirect(url_for("login"))


    mydb.connect()
    cursor = mydb.cursor()

    cursor.execute("DELETE FROM user WHERE id_user=%s",(id,))

    mydb.commit()
    cursor.close()
    mydb.close()

    return redirect(url_for("user"))

####################################################


##################### SAPI ROUTE ###################


@app.route("/sapi")
def sapi():

    mydb.connect()
    
    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM sapi")

    rows = cursor.fetchall()

    cursor.close()
    mydb.close()

    return render_template("sapi.html",rows=rows)

@app.route("/sapi/update/<id>")
def sapi_update(id):
    return id

@app.route("/sapi/content/<id>", methods=["POST","GET"])
def sapi_updatecontent(id):

    if request.method=="POST":
        content = request.form["content"]

        mydb.connect()
        cursor = mydb.cursor()
        cursor.execute("UPDATE sapi SET content=%s WHERE id_sapi=%s",(content,id))

        mydb.commit()

        cursor.close()
        mydb.close()

        return redirect(url_for("sapi"))


    mydb.connect()
    
    cursor = mydb.cursor()
    cursor.execute("SELECT * FROM sapi WHERE id_sapi=%s",(id,))

    row = cursor.fetchone()

    cursor.close()
    mydb.close()

    if row==None:
        return redirect(url_for("sapi"))
    else:
        return render_template("sapi:content.html", row=row)

####################################################


@app.route("/classification", methods=["POST"])
def classification():
    try:
        files = request.files["image"].read()

        image = Image.open(BytesIO(files))

        imagearray = np.array(image)

        resized = cv2.resize(imagearray, (180,180))

        expanded = tf.expand_dims(resized,0)

        predictions = model.predict(expanded)
        score = tf.nn.softmax(predictions[0])

        text = "Gambar ini terklasifikasi sebagai {} dengan tingkat keyakinan {:.2f}%.".format(class_names[np.argmax(score)], 100 * np.max(score))
        index = np.argmax(score)
        tingkatkeyakinan = 100 * np.max(score)
        namasapi = class_names[np.argmax(score)]

        mydb.connect()
        
        cursor = mydb.cursor()
        cursor.execute("SELECT * FROM sapi WHERE id_sapi=%s",(int(index),))

        rows = cursor.fetchone()

        cursor.close()
        mydb.close()

        return jsonify({
            "success":True,
            "datasapi":{
                "id_sapi":rows[0],
                "nama_sapi":rows[1],
                "image":rows[3],
                "content":rows[2]
            },
            "data":{
                "text":text,
                "index_class":int(index),
                "class_name":class_names,
                "keyakinan":tingkatkeyakinan,
                "klasifikasi":namasapi
            }
        })
        

    except Exception as e:

        print(e)
        return jsonify({
            "success":False,
            "msg":str(e)
        })

@app.route("/classificationchicken", methods=["POST"])
def classificationchicken():
    try:
        files = request.files["image"].read()

        image = Image.open(BytesIO(files))

        imagearray = np.array(image)

        resized = cv2.resize(imagearray, (180,180))

        expanded = tf.expand_dims(resized,0)

        predictions = model.predict(expanded)
        score = tf.nn.softmax(predictions[0])

        text = "Gambar ini terklasifikasi sebagai {} dengan tingkat keyakinan {:.2f}%.".format(class_names_ayam[np.argmax(score)], 100 * np.max(score))
        index = np.argmax(score)
        tingkatkeyakinan = 100 * np.max(score)
        namaayam = class_names_ayam[np.argmax(score)]

        mydb.connect()
        
        cursor = mydb.cursor()
        cursor.execute("SELECT * FROM ayam WHERE id_ayam=%s",(int(index),))

        rows = cursor.fetchone()

        cursor.close()
        mydb.close()

        return jsonify({
            "success":True,
            "datasapi":{
                "id_ayam":rows[0],
                "nama_ayam":rows[1],
                "image":rows[2],
                "content":rows[3]
            },
            "data":{
                "text":text,
                "index_class":int(index),
                "class_name":class_names_ayam,
                "keyakinan":tingkatkeyakinan,
                "klasifikasi":namasapi
            }
        })
        

    except Exception as e:

        print(e)
        return jsonify({
            "success":False,
            "msg":str(e)
        })


@app.route("/classificationCowOrNot", methods=["POST"])
def cowornot():
    try:
        class_cowornot = ['Bukan Sapi', 'Sapi']

        files = request.files["image"].read()

        file = BytesIO(files)

        file.seek(0)

        id = uuid.uuid4()
        id = str(id)

        with open(id+'.jpg', 'wb') as f:
            f.write(file.getbuffer())

        imread = cv2.imread(id+'.jpg')
        canny = Canny_detector(imread)

        cv2.imwrite(id+'.jpg',canny)

        img = keras.preprocessing.image.load_img(id+'.jpg', target_size=(180,180))

        img_array = keras.preprocessing.image.img_to_array(img)
        img_array = tf.expand_dims(img_array, 0) # Create a batch

        predictions = model.predict(img_array)

        score = tf.nn.softmax(predictions[0])

        return "This image most likely belongs to {} with a {:.2f} percent confidence.".format(class_cowornot[np.argmax(score)], 100 * np.max(score))

        return jsonify({
            "success":True,
            "result":class_cowornot[np.argmax(score)]
        })

        # image = Image.open(BytesIO(files))

        # imagearray = np.array(image)

        # imagearray = Canny_detector(imagearray)

        # resized = cv2.resize(imagearray, (180,180))

        # expanded = tf.expand_dims(resized,0)

        # predictions = model.predict(expanded)
        # score = tf.nn.softmax(predictions[0])

        # text = "Gambar ini terklasifikasi sebagai {} dengan tingkat keyakinan {:.2f}%.".format(class_names[np.argmax(score)], 100 * np.max(score))
        # index = np.argmax(score)
        
        # classCowOrNot = ['Bukan Sapi', 'Sapi']

        # if classCowOrNot[index]=="Bukan Sapi":
        #     return jsonify({
        #         "success":True,
        #         "sapi":False
        #     })
        # else:
        #     return jsonify({
        #         "success":True,
        #         "sapi":False
        #     })

    except Exception as e:

        print(e)
        return jsonify({
            "success":False,
            "msg":str(e)
        })

if __name__=='__main__':
    app.run(host="0.0.0.0",debug=True)

