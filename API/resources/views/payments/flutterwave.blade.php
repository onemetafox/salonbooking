<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay with Flutterwave</title>
    <script src="https://checkout.flutterwave.com/v3.js"></script>
    <script type="text/javascript">
        function flutterWave(){
            FlutterwaveCheckout({
                public_key: "{{$key}}",
                tx_ref: '' + Math.floor((Math.random() * 1000000000) + 1),
                amount:  {{$amount}},
                currency:"{{$code}}" ,
                payment_options: "card, mobilemoneyghana, ussd",
                redirect_url: 
                     "{{$callback}}",
                customer: {
                    email:"{{$email}}",
                    phone_number: "{{$phone}}",
                    name: "{{$name}}",
                },
                callback: function (data) {
                    console.log(data);
                },
                onclose: function() {
                    // close modal
                    console.log('closed');
                    window.location.replace("{{$errorCallBack}}");
                    
                },
                customizations: {
                    title: "{{$app_name}}"+" Orders",
                    description: "Payment for items in cart",
                    logo: "{{$logo}}",
                },
                });
        }
    window.onload = flutterWave;
    </script>
</head>
<body>
    
</body>
</html>