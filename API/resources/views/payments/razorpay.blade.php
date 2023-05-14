<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay with RazorPay</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script type="text/javascript">
        function initRazor(){
            var options = {
            "key": '{{ $key }}',
            "amount": {{$amount}},
            "name": "{{$name}}",
            "description": 'Dining',
            "image": "{{$logo}}",
            "redirect":true,
            "handler": function (response) {
                console.log(response);
                let url = "{{$url}}";
                if(response && response.razorpay_payment_id){
                    window.location.replace(url+"?pay_id="+response.razorpay_payment_id);
                }
            },
            "prefill": {
                "email":"{{$email}}",// customer email
            },
            "theme": {
                "color":"{{$app_color}}" // screen color
            }
        };
            console.log(options);
            var propay = new Razorpay(options);
            propay.open();
        }
    window.onload = initRazor;
    </script>
</head>
<body>
    
</body>
</html>