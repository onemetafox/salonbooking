<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay with PayStack</title>
    <script src="https://js.paystack.co/v1/inline.js"></script>
    <script type="text/javascript">
        function initpayStack(){
                let handler = PaystackPop.setup({
                key: "{{$key}}",
                email: "{{$email}}",
                amount: {{$amount}},
                firstname: "{{$first_name}}",
                lastname: "{{$last_name}}",
                ref:"{{$ref}}", 
                onClose: function(){
                    window.location.replace("{{$errorCallBack}}");
                },
                callback: function(response){
                    window.location.replace("{{$sucessCallBack}}"+"?id="+response.reference);
                }
            });
            handler.openIframe();
        }
        window.onload = initpayStack;
    </script>
</head>
<body>
    
</body>
</html>