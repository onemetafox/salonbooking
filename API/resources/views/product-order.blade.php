<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Invoice #{{$data->id}} </title>
    <style>
        body {
            font-family: Helvetica, sans-serif;
            font-size: 13px;
        }

        .container {
            max-width: 680px;
            margin: 0 auto;
        }

        .logotype {
            background: #000;
            color: #fff;
            width: 75px;
            height: 75px;
            line-height: 75px;
            text-align: center;
            font-size: 11px;
        }

        .column-title {
            background: #eee;
            text-transform: uppercase;
            padding: 15px 5px 15px 15px;
            font-size: 11px
        }

        .column-detail {
            border-top: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }

        .column-header {
            background: #eee;
            text-transform: uppercase;
            padding: 15px;
            font-size: 11px;
            border-right: 1px solid #eee;
        }

        .row {
            padding: 7px 14px;
            border-left: 1px solid #eee;
            border-right: 1px solid #eee;
            border-bottom: 1px solid #eee;
        }

        .alert {
            background: #ffd9e8;
            padding: 20px;
            margin: 20px 0;
            line-height: 22px;
            color: #333
        }

        .socialmedia {
            background: #eee;
            padding: 20px;
            display: inline-block
        }

        @page {
            margin: 0;
        }

        @media print {
            .hideMe {
                display: none;
            }
        }

        .noPrint {
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
            margin: 20px 0px;
        }
    </style>
</head>

<body>
    <div class="noPrint">
        <button onclick="window.print();" class="hideMe" style="padding: 10px;border-radius: 5px;; cursor: pointer;">
            Print Invoice
        </button>
    </div>
    <div class="container">

        <h3>Your contact details</h3>

        <table width="100%" style="border-collapse: collapse;">
            <tr>
                <td widdth="50%" style="background:#eee;padding:20px 5px;">
                    <strong>Date:</strong>  {{$data->date_time}} <br>
                    <strong>Payment type:</strong> {{$data->paid_method}}<br>
                    <strong>Service At:</strong>  {{$data->order_to == 1 ? 'Home':'At Freelancer'}} <br>
                </td>
                <td style="background:#eee;padding:20px 5px;">
                    <strong>Order-no:</strong> {{$data->id}}<br>
                    <strong>E-mail:</strong> {{$general->email}} <br>
                    <strong>Phone:</strong> {{$general->mobile}}<br>
                </td>
            </tr>
        </table><br>
        <table width="100%">
            <tr>
                <td>
                    <table>
                        <tr>
                            @if($data->freelancer_id == 0)
                                <td>
                                    Seller<br>
                                    <strong>{{$data->freelancerInfo->first_name}} {{$data->freelancerInfo->last_name}}</strong> <br>
                                    {{$data->freelancerInfo->email}}<br>
                                    {{$data->freelancerInfo->mobile}}<br>
                                </td>
                            @endif

                            @if($data->salon_id == 0)
                                <td>
                                Seller<br>
                                    <strong>{{$data->freelancerInfo->first_name}} {{$data->freelancerInfo->last_name}} </strong> <br>
                                    {{$data->freelancerInfo->email}}<br>
                                    {{$data->freelancerInfo->mobile}}<br>
                                </td>
                            @endif
                        </tr>
                    </table>
                </td>
                <td>
                    <table>
                        <tr>

                            <td>
                                Customer<br>
                                <strong>{{$data->userInfo->first_name}} {{$data->userInfo->last_name}}</strong> <br>
                                {{$delivery->house}} {{$delivery->landmark}} <br>
                                {{$delivery->address}} <br>
                                {{$delivery->pincode}}

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table><br>

        <h3>Your Orders</h3>

        <table width="100%" style="border-collapse: collapse;border-bottom:1px solid #eee;">
            <tr>
                <td width="40%" class="column-header">Orders</td>
                <td width="20%" class="column-header">Quantity</td>
                <td width="20%" class="column-header">Total</td>
            </tr>
            @foreach($data->orders as $order)
            <tr>
                <td class="row"><span style="color:#777;font-size:11px;">#{{$order->id}}</span><br>{{$order->name}}</td>
                <td class="row">X {{$order->quantity}} </td>
                <td class="row">
                @if($order->discount > 0)
                    {{$general->currencySymbol}} {{$order->sell_price}}
                @endif

                @if($order->discount <= 0)
                    {{$general->currencySymbol}} {{$order->original_price}}
                @endif
                </td>
            </tr>
            @endforeach

        </table><br>
        <table width="100%" style="background:#eee;padding:20px;">
            <tr>
                <td>
                    <table width="300px" style="float:right">
                        <tr>
                            <td><strong>Sub-total:</strong></td>
                            <td style="text-align:right">{{$general->currencySymbol}} {{$data->total}} </td>
                        </tr>
                        <tr>
                            <td><strong>Discount:</strong></td>
                            <td style="text-align:right"> - {{$general->currencySymbol}} {{$data->discount}} </td>
                        </tr>
                        <tr>
                            <td><strong>Wallet Discount:</strong></td>
                            <td style="text-align:right"> - {{$general->currencySymbol}} {{$data->wallet_price}} </td>
                        </tr>
                        <tr>
                            <td><strong>Delivery fee:</strong></td>
                            <td style="text-align:right">{{$general->currencySymbol}} {{$data->delivery_charge}} </td>
                        </tr>
                        <tr>
                            <td><strong>Tax:</strong></td>
                            <td style="text-align:right">{{$general->currencySymbol}} {{$data->tax}} </td>
                        </tr>
                        <tr>
                            <td><strong>Grand total:</strong></td>
                            <td style="text-align:right">{{$general->currencySymbol}} {{$data->grand_total}} </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br>

    </div><!-- container -->
</body>

</html>
