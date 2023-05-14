<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Firebase Auth</title>
    <style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:300);

        .login-page {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 90%;
        }

        .form {
            position: relative;
            z-index: 1;
            background: #FFFFFF;
            max-width: 360px;
            margin: 0 auto 100px;
            padding: 45px;
            text-align: center;
            box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
        }

        .form input {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            width: 100%;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
        }

        .form button {
            font-family: "Roboto", sans-serif;
            text-transform: uppercase;
            outline: 0;
            background: gray;
            width: 100%;
            border: 0;
            padding: 15px;
            color: #FFFFFF;
            font-size: 14px;
            -webkit-transition: all 0.3 ease;
            transition: all 0.3 ease;
            cursor: pointer;
        }

        .form button:hover,
        .form button:active,
        .form button:focus {
            background: #43A047;
        }

        .form .message {
            margin: 15px 0 0;
            color: #b3b3b3;
            font-size: 12px;
        }

        .form .message a {
            color: #4CAF50;
            text-decoration: none;
        }

        .form .register-form {
            display: none;
        }

        .container {
            position: relative;
            z-index: 1;
            max-width: 300px;
            margin: 0 auto;
        }

        .container:before,
        .container:after {
            content: "";
            display: block;
            clear: both;
        }

        .container .info {
            margin: 50px auto;
            text-align: center;
        }

        .container .info h1 {
            margin: 0 0 15px;
            padding: 0;
            font-size: 36px;
            font-weight: 300;
            color: #1a1a1a;
        }

        .container .info span {
            color: #4d4d4d;
            font-size: 12px;
        }

        .container .info span a {
            color: #000000;
            text-decoration: none;
        }

        .container .info span .fa {
            color: #EF3B3A;
        }

        body {
            font-family: "Roboto", sans-serif;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }

        .input-elements {
            display: flex;
            flex-direction: row;
            justify-content: space-around;
            width: 100%;
        }

        .select_btn {
            font-family: "Roboto", sans-serif;
            outline: 0;
            background: #f2f2f2;
            border: 0;
            margin: 0 0 15px;
            padding: 15px;
            box-sizing: border-box;
            font-size: 14px;
            width: 40%;
        }
    </style>

</head>

<body>
    <div id="recaptcha-container"></div>
    <script src="https://www.gstatic.com/firebasejs/4.8.1/firebase.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script type="text/javascript">
       const config = {
            apiKey: "AIzaSyBuzAchIHNyH-iEL-0aYImLp_t_vCa9rRU",
            authDomain: "foodies-25317.firebaseapp.com",
            databaseURL: "https://foodies-25317.firebaseio.com",
            projectId: "foodies-25317",
            storageBucket: "foodies-25317.appspot.com",
            messagingSenderId: "62057288644",
            appId: "1:62057288644:web:e2452af9d3051bedd74a91",
            measurementId: "G-FG669D56ES"
        };
        firebase.initializeApp(config);
    </script>
    <script type="text/javascript">


    const number = "+"+({{$mobile}}).toString();
    console.log(number);
        window.recaptchaVerifier = new firebase.auth.RecaptchaVerifier('recaptcha-container');
        firebase.auth()
        .signInWithPhoneNumber(number, window.recaptchaVerifier)
        .then(function (confirmationResult) {
          window.confirmationResult = confirmationResult;
          console.log(confirmationResult);
        }).catch((error)=>{
            console.log(error);
                if(error && error.message){
                    swal("Error", error.message, "error");
                }else{
                    swal("Error", "Something went wrong", "error");
                }
        });

        var verify = function() {
            let url = "{{$redirect}}";
            window.confirmationResult.confirm(document.getElementById("verificationcode").value)
            .then((result) =>{
                console.log(result);
                window.location.replace(url);
            }).catch((error)=> {
                console.log(error);
                if(error && error.message){
                    swal("Error", error.message, "error");
                }else{
                    swal("Error", "Invalid code", "error");
                }

            });
        };
    </script>
    <div class="login-page">
        <div class="form">
            <div class="input-elements">
                <input type="text" placeholder="OTP" id="verificationcode" required />
            </div>
            <div class="login-form">
                <button onclick="verify()" class="send-otp" type="submit">Verify OTP</button>
            </div>
        </div>
    </div>
</body>

</html>
