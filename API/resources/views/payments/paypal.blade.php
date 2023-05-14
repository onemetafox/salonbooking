<!DOCTYPE html>

<head>
  <meta name="viewport" content="width=device-width, initial-scale=1"> <!-- Ensures optimal rendering on mobile devices. -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge" /> <!-- Optimal Internet Explorer compatibility -->
  <script
    src="https://www.paypal.com/sdk/js?client-id={{ $client_id }}"> // Required FROM STORED. Replace YOUR_CLIENT_ID with your sandbox client ID.
  </script>
</head>

<body>
  
   <div id="paypal-button-container"></div>


<script>
  paypal.Buttons({
    createOrder: function(data, actions) {
      return actions.order.create({
        purchase_units: [{
          amount: {
            value: {{$amount}}
          }
        }]
      });
    },
    onApprove: function(data, actions) {
      let url = "{{$url}}";
      return actions.order.capture().then(function(details) {
        if(details && details.status ==='COMPLETED'){
          window.location.replace(url+"?pay_id="+details.purchase_units[0].payments.captures[0].id);
        }else{
          alert('something went wrong please contact your administrator paypal');
        }
        // 
      });
    }
  }).render('#paypal-button-container');
</script>
</body>
</html>