<?php

namespace App\Http\Controllers\v1;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Appointments;
use App\Models\ProductOrders;
use Validator;
use DB;

class PaytmPayController extends Controller
{
    public function payNow(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $order_id = uniqid();
        $data_for_request = $this->handlePaytmRequest($order_id, $request->amount);

        $paytm_txn_url = 'https://securegw-stage.paytm.in/theia/processTransaction';
        $paramList = $data_for_request['paramList'];
        $checkSum = $data_for_request['checkSum'];

        return view('payments/paytm', compact('paytm_txn_url', 'paramList', 'checkSum'));
    }

    public function payNowWeb(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'standby_id'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $order_id = uniqid();
        $data_for_request = $this->handleWebPaytmRequest($order_id, $request->amount,$request->standby_id);

        $paytm_txn_url = 'https://securegw-stage.paytm.in/theia/processTransaction';
        $paramList = $data_for_request['paramList'];
        $checkSum = $data_for_request['checkSum'];

        return view('payments/paytm', compact('paytm_txn_url', 'paramList', 'checkSum'));
    }


    public function handlePaytmRequest($order_id, $amount){
        // Load all functions of encdec_paytm.php and config-paytm.php
        $this->getAllEncdecFunc();
        $this->getConfigPaytmSettings();
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        $credsData = json_decode($payCreds->creds);

        $checkSum = "";
        $paramList = array();
        // $payments_setting = $this->order->payments_setting_for_paytm();
        // Create an array having all required parameters for creating checksum.
        $paramList["MID"] = $credsData->mid;
        $paramList["ORDER_ID"] = $order_id;
        $paramList["CUST_ID"] = $order_id;
        $paramList["INDUSTRY_TYPE_ID"] = 'Retail';
        $paramList["CHANNEL_ID"] = 'WEB';
        $paramList["TXN_AMOUNT"] = $amount;
        $paramList["WEBSITE"] = $credsData->stage;
        $paramList["CALLBACK_URL"] = url('/api/v1/paytm-callback');
        $paytm_merchant_key = $credsData->key;

        //Here checksum string will return by getChecksumFromArray() function.
        $checkSum = getChecksumFromArray($paramList, $paytm_merchant_key);

        return array(
            'checkSum' => $checkSum,
            'paramList' => $paramList,
        );
    }

    public function handleWebPaytmRequest($order_id, $amount,$standby_id){
        // Load all functions of encdec_paytm.php and config-paytm.php
        $this->getAllEncdecFunc();
        $this->getConfigPaytmSettings();

        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        $credsData = json_decode($payCreds->creds);

        $checkSum = "";
        $paramList = array();
        // $payments_setting = $this->order->payments_setting_for_paytm();
        // Create an array having all required parameters for creating checksum.
        $paramList["MID"] = $credsData->mid;
        $paramList["ORDER_ID"] = $order_id;
        $paramList["CUST_ID"] = $order_id;
        $paramList["INDUSTRY_TYPE_ID"] = 'Retail';
        $paramList["CHANNEL_ID"] = 'WEB';
        $paramList["TXN_AMOUNT"] = $amount;
        $paramList["WEBSITE"] = $credsData->stage;
        $paramList["CALLBACK_URL"] = url('/api/v1/paytm-webCallback?standby_id='.$standby_id);
        $paytm_merchant_key = $credsData->key;

        //Here checksum string will return by getChecksumFromArray() function.
        $checkSum = getChecksumFromArray($paramList, $paytm_merchant_key);

        return array(
            'checkSum' => $checkSum,
            'paramList' => $paramList,
        );
    }

    public function callBack(Request $request){
        echo json_encode($request->all());
    }


    public function refundUserRequest(Request $request){
        // $order_id = uniqid();
        $validator = Validator::make($request->all(), [
            'id' => 'required',
            'txt_id'=>'required',
            'amount'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }

        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }

        $data_for_request = $this->getRefundChecksum($request->id, $request->amount,$request->txt_id);

        $paytm_txn_url = 'https://securegw-stage.paytm.in/theia/processTransaction';
        $paramList = $data_for_request['paramList'];
        $checkSum = $data_for_request['checkSum'];

        $paramList["head"] = array(
            "signature"	  => $checkSum
        );

        $post_data = json_encode($paramList, JSON_UNESCAPED_SLASHES);


        /* for Staging */
        $url = "https://securegw-stage.paytm.in/refund/apply";

        /* for Production */
        // $url = "https://securegw.paytm.in/refund/apply";

        // $ch = curl_init($url);
        // curl_setopt($ch, CURLOPT_POST, 1);
        // curl_setopt($ch, CURLOPT_POSTFIELDS, $post_data);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        // curl_setopt($ch, CURLOPT_HTTPHEADER, array("Content-Type: application/json"));
        // $response = curl_exec($ch);
        // print_r($response);

        // echo json_encode($checkSum);
        //
        $uri;
        if($credsData->env == 'TEST'){
            $uri = "https://securegw-stage.paytm.in/refund/apply";
        }else{
            $uri = "https://securegw.paytm.in/refund/apply";
        }
        $client = new \GuzzleHttp\Client();
        $bodyRAW = array();
        $bodyRAW["mid"] = $credsData->mid;
        $bodyRAW["txnType"] = 'REFUND';
        $bodyRAW["orderId"] = $request->id;
        $bodyRAW["txnId"] = $request->txt_id;
        $bodyRAW["refId"] = 'refIdILLD';
        $bodyRAW["refundAmount"] = $request->amount;
        $bodyRAW["head"] = array(
            "signature"	  => $checkSum
        );

        $response = $client->request('POST', $uri, [
                'headers' =>
                    [
                        'Accept' => 'application/json',
                        'Accept-Language' => 'en_US',
                    'Content-Type' => 'application/x-www-form-urlencoded',
                    ],
                'body' => json_encode($bodyRAW),
            ]
        );

        $data = json_decode($response->getBody(), true);
        $response = [
            'success' => $data,
            'message' => 'success',
            'status' => 200
        ];
        return $response;
    }

    // 20210701111212800110168249602757078
    // 60dd3a461ea21
    // 150.00
    public function getRefundChecksum($order_id, $amount,$txn_id)
    {
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        // Load all functions of encdec_paytm.php and config-paytm.php
        $this->getAllEncdecFunc();
        $this->getConfigPaytmSettings();

        $checkSum = "";
        $paramList = array();
        // $payments_setting = $this->order->payments_setting_for_paytm();
        // Create an array having all required parameters for creating checksum.
        $paramList["MID"] = $credsData->mid;
        $paramList["ORDER_ID"] = $order_id;
        $paramList["CUST_ID"] = $order_id;
        $paramList["INDUSTRY_TYPE_ID"] = 'Retail';
        $paramList["CHANNEL_ID"] = 'WEB';
        $paramList["TXN_AMOUNT"] = $amount;
        $paramList["TXN_ID"] = $txn_id;
        $paramList["WEBSITE"] = $credsData->stage;
        $paramList["CALLBACK_URL"] = url('/paytm-callback');
        $paytm_merchant_key = $credsData->key;

        //Here checksum string will return by getChecksumFromArray() function.
        $checkSum = getChecksumFromArray($paramList, $paytm_merchant_key);

        return array(
            'checkSum' => $checkSum,
            'paramList' => $paramList,
        );
    }


    /**
     * Get all the functions from encdec_paytm.php
     */
    public function getAllEncdecFunc()
    {
        function encrypt_e($input, $ky)
        {
            $key = html_entity_decode($ky);
            $iv = "@@@@&&&&####$$$$";
            $data = openssl_encrypt($input, "AES-128-CBC", $key, 0, $iv);
            return $data;
        }

        function decrypt_e($crypt, $ky)
        {
            $key = html_entity_decode($ky);
            $iv = "@@@@&&&&####$$$$";
            $data = openssl_decrypt($crypt, "AES-128-CBC", $key, 0, $iv);
            return $data;
        }

        function pkcs5_pad_e($text, $blocksize)
        {
            $pad = $blocksize - (strlen($text) % $blocksize);
            return $text . str_repeat(chr($pad), $pad);
        }

        function pkcs5_unpad_e($text)
        {
            $pad = ord($text[strlen($text)-1]);
            if ($pad > strlen($text)) return false;
            if (strspn($text, chr($pad), strlen($text) - $pad) != $pad) return false;
            return substr($text, 0, -1 * $pad);
            // $pad = ord($text{strlen($text) - 1});
            // if ($pad > strlen($text)) {
            //     return false;
            // }

            // return substr($text, 0, -1 * $pad);
        }

        function generateSalt_e($length)
        {
            $random = "";
            srand((double) microtime() * 1000000);

            $data = "AbcDE123IJKLMN67QRSTUVWXYZ";
            $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz";
            $data .= "0FGH45OP89";

            for ($i = 0; $i < $length; $i++) {
                $random .= substr($data, (rand() % (strlen($data))), 1);
            }

            return $random;
        }

        function checkString_e($value)
        {
            if ($value == 'null') {
                $value = '';
            }

            return $value;
        }

        function getChecksumFromArray($arrayList, $key, $sort = 1)
        {
            if ($sort != 0) {
                ksort($arrayList);
            }
            $str = getArray2Str($arrayList);
            $salt = generateSalt_e(4);
            $finalString = $str . "|" . $salt;
            $hash = hash("sha256", $finalString);
            $hashString = $hash . $salt;
            $checksum = encrypt_e($hashString, $key);
            return $checksum;
        }
        function getChecksumFromString($str, $key)
        {

            $salt = generateSalt_e(4);
            $finalString = $str . "|" . $salt;
            $hash = hash("sha256", $finalString);
            $hashString = $hash . $salt;
            $checksum = encrypt_e($hashString, $key);
            return $checksum;
        }

        function verifychecksum_e($arrayList, $key, $checksumvalue)
        {
            $arrayList = removeCheckSumParam($arrayList);
            ksort($arrayList);
            $str = getArray2StrForVerify($arrayList);
            $paytm_hash = decrypt_e($checksumvalue, $key);
            $salt = substr($paytm_hash, -4);

            $finalString = $str . "|" . $salt;

            $website_hash = hash("sha256", $finalString);
            $website_hash .= $salt;

            $validFlag = "FALSE";
            if ($website_hash == $paytm_hash) {
                $validFlag = "TRUE";
            } else {
                $validFlag = "FALSE";
            }
            return $validFlag;
        }

        function verifychecksum_eFromStr($str, $key, $checksumvalue)
        {
            $paytm_hash = decrypt_e($checksumvalue, $key);
            $salt = substr($paytm_hash, -4);

            $finalString = $str . "|" . $salt;

            $website_hash = hash("sha256", $finalString);
            $website_hash .= $salt;

            $validFlag = "FALSE";
            if ($website_hash == $paytm_hash) {
                $validFlag = "TRUE";
            } else {
                $validFlag = "FALSE";
            }
            return $validFlag;
        }

        function getArray2Str($arrayList)
        {
            $findme = 'REFUND';
            $findmepipe = '|';
            $paramStr = "";
            $flag = 1;
            foreach ($arrayList as $key => $value) {
                $pos = strpos($value, $findme);
                $pospipe = strpos($value, $findmepipe);
                if ($pos !== false || $pospipe !== false) {
                    continue;
                }

                if ($flag) {
                    $paramStr .= checkString_e($value);
                    $flag = 0;
                } else {
                    $paramStr .= "|" . checkString_e($value);
                }
            }
            return $paramStr;
        }

        function getArray2StrForVerify($arrayList)
        {
            $paramStr = "";
            $flag = 1;
            foreach ($arrayList as $key => $value) {
                if ($flag) {
                    $paramStr .= checkString_e($value);
                    $flag = 0;
                } else {
                    $paramStr .= "|" . checkString_e($value);
                }
            }
            return $paramStr;
        }

        function redirect2PG($paramList, $key)
        {
            $hashString = getchecksumFromArray($paramList, $key);
            $checksum = encrypt_e($hashString, $key);
        }

        function removeCheckSumParam($arrayList)
        {
            if (isset($arrayList["CHECKSUMHASH"])) {
                unset($arrayList["CHECKSUMHASH"]);
            }
            return $arrayList;
        }

        function getTxnStatus($requestParamList)
        {
            return callAPI(PAYTM_STATUS_QUERY_URL, $requestParamList);
        }

        function getTxnStatusNew($requestParamList)
        {
            return callNewAPI(PAYTM_STATUS_QUERY_NEW_URL, $requestParamList);
        }

        function initiateTxnRefund($requestParamList)
        {
            $CHECKSUM = getRefundChecksumFromArray($requestParamList, PAYTM_MERCHANT_KEY, 0);
            $requestParamList["CHECKSUM"] = $CHECKSUM;
            return callAPI(PAYTM_REFUND_URL, $requestParamList);
        }

        function callAPI($apiURL, $requestParamList)
        {
            $jsonResponse = "";
            $responseParamList = array();
            $JsonData = json_encode($requestParamList);
            $postData = 'JsonData=' . urlencode($JsonData);
            $ch = curl_init($apiURL);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($postData))
            );
            $jsonResponse = curl_exec($ch);
            $responseParamList = json_decode($jsonResponse, true);
            return $responseParamList;
        }

        function callNewAPI($apiURL, $requestParamList)
        {
            $jsonResponse = "";
            $responseParamList = array();
            $JsonData = json_encode($requestParamList);
            $postData = 'JsonData=' . urlencode($JsonData);
            $ch = curl_init($apiURL);
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($postData))
            );
            $jsonResponse = curl_exec($ch);
            $responseParamList = json_decode($jsonResponse, true);
            return $responseParamList;
        }
        function getRefundChecksumFromArray($arrayList, $key, $sort = 1)
        {
            if ($sort != 0) {
                ksort($arrayList);
            }
            $str = getRefundArray2Str($arrayList);
            $salt = generateSalt_e(4);
            $finalString = $str . "|" . $salt;
            $hash = hash("sha256", $finalString);
            $hashString = $hash . $salt;
            $checksum = encrypt_e($hashString, $key);
            return $checksum;
        }
        function getRefundArray2Str($arrayList)
        {
            $findmepipe = '|';
            $paramStr = "";
            $flag = 1;
            foreach ($arrayList as $key => $value) {
                $pospipe = strpos($value, $findmepipe);
                if ($pospipe !== false) {
                    continue;
                }

                if ($flag) {
                    $paramStr .= checkString_e($value);
                    $flag = 0;
                } else {
                    $paramStr .= "|" . checkString_e($value);
                }
            }
            return $paramStr;
        }
        function callRefundAPI($refundApiURL, $requestParamList)
        {
            $jsonResponse = "";
            $responseParamList = array();
            $JsonData = json_encode($requestParamList);
            $postData = 'JsonData=' . urlencode($JsonData);
            $ch = curl_init($apiURL);
            curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
            curl_setopt($ch, CURLOPT_URL, $refundApiURL);
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $postData);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            $headers = array();
            $headers[] = 'Content-Type: application/json';
            curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            $jsonResponse = curl_exec($ch);
            $responseParamList = json_decode($jsonResponse, true);
            return $responseParamList;
        }
    }

    /**
     * Config Paytm Settings from config_paytm.php file of paytm kit
     */
    public function getConfigPaytmSettings()
    {
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        $credsData = json_decode($payCreds->creds);
        define('PAYTM_ENVIRONMENT', $credsData->env); // PROD
        define('PAYTM_MERCHANT_KEY', $credsData->key); //Change this constant's value with Merchant key downloaded from portal
        define('PAYTM_MERCHANT_MID', $credsData->mid); //Change this constant's value with MID (Merchant ID) received from Paytm
        define('PAYTM_MERCHANT_WEBSITE', $credsData->stage); //Change this constant's value with Website name received from Paytm

        $PAYTM_STATUS_QUERY_NEW_URL = 'https://securegw-stage.paytm.in/merchant-status/getTxnStatus';
        $PAYTM_TXN_URL = 'https://securegw-stage.paytm.in/theia/processTransaction';
        if (PAYTM_ENVIRONMENT == 'PROD') {
            $PAYTM_STATUS_QUERY_NEW_URL = 'https://securegw.paytm.in/merchant-status/getTxnStatus';
            $PAYTM_TXN_URL = 'https://securegw.paytm.in/theia/processTransaction';
        }
        define('PAYTM_REFUND_URL', '');
        define('PAYTM_STATUS_QUERY_URL', $PAYTM_STATUS_QUERY_NEW_URL);
        define('PAYTM_STATUS_QUERY_NEW_URL', $PAYTM_STATUS_QUERY_NEW_URL);
        define('PAYTM_TXN_URL', $PAYTM_TXN_URL);
    }

    public function paytmCallback(Request $request)
    {
        $order_id = $request['ORDERID'];

        if ('TXN_SUCCESS' === $request['STATUS']) {
            return redirect(url('/api/v1/success_payments?id='.$request['ORDERID'].'&txt_id='.$request['TXNID']));

        } else if ('TXN_FAILURE' === $request['STATUS']) {
            return redirect(url('/api/v1/failed_payments?id='.$request['ORDERID']));
        }
    }


    public function refundAmount(){

    }

    public function webCallback(Request $request){
        $order_id = $request['ORDERID'];

        if ('TXN_SUCCESS' === $request['STATUS']) {
            $paid= ['key'=>$request['ORDERID'],'txtId'=>$request['TXNID']];
            $data = Appointments::find($request->standby_id)->update(['status'=>0,'paid'=>json_encode($paid)]);
            if (is_null($data)) {
                return redirect(url('/api/v1/failed_payments?id='.$request['ORDERID']));
            }
            return view('payments/paytmWeb');

        } else if ('TXN_FAILURE' === $request['STATUS']) {
            return redirect(url('/api/v1/failed_payments?id='.$request['ORDERID']));
        }
    }

    public function payProductWeb(Request $request){
        $validator = Validator::make($request->all(), [
            'amount' => 'required',
            'standby_id'=>'required'
        ]);
        if ($validator->fails()) {
            $response = [
                'success' => false,
                'message' => 'Validation Error.', $validator->errors(),
                'status'=> 500
            ];
            return response()->json($response, 404);
        }
        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        if (is_null($payCreds) || is_null($payCreds->creds)) {
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $credsData = json_decode($payCreds->creds);
        if(is_null($credsData) || is_null($credsData->key)){
            $response = [
                'success' => false,
                'message' => 'Payment issue please contact administrator',
                'status' => 404
            ];
            return response()->json($response, 404);
        }
        $order_id = uniqid();
        $data_for_request = $this->handleWebPaytmRequestProduct($order_id, $request->amount,$request->standby_id);

        $paytm_txn_url = 'https://securegw-stage.paytm.in/theia/processTransaction';
        $paramList = $data_for_request['paramList'];
        $checkSum = $data_for_request['checkSum'];

        return view('payments/paytm', compact('paytm_txn_url', 'paramList', 'checkSum'));
    }

    public function handleWebPaytmRequestProduct($order_id, $amount,$standby_id){
        // Load all functions of encdec_paytm.php and config-paytm.php
        $this->getAllEncdecFunc();
        $this->getConfigPaytmSettings();

        $payCreds = DB::table('payments')
        ->select('*')->where('id',4)->first();
        $credsData = json_decode($payCreds->creds);

        $checkSum = "";
        $paramList = array();
        // $payments_setting = $this->order->payments_setting_for_paytm();
        // Create an array having all required parameters for creating checksum.
        $paramList["MID"] = $credsData->mid;
        $paramList["ORDER_ID"] = $order_id;
        $paramList["CUST_ID"] = $order_id;
        $paramList["INDUSTRY_TYPE_ID"] = 'Retail';
        $paramList["CHANNEL_ID"] = 'WEB';
        $paramList["TXN_AMOUNT"] = $amount;
        $paramList["WEBSITE"] = $credsData->stage;
        $paramList["CALLBACK_URL"] = url('/api/v1/paytm-webCallbackProduct?standby_id='.$standby_id);
        $paytm_merchant_key = $credsData->key;

        //Here checksum string will return by getChecksumFromArray() function.
        $checkSum = getChecksumFromArray($paramList, $paytm_merchant_key);

        return array(
            'checkSum' => $checkSum,
            'paramList' => $paramList,
        );
    }

    public function webCallbackProduct(Request $request){
        $order_id = $request['ORDERID'];

        if ('TXN_SUCCESS' === $request['STATUS']) {
            $paid= ['key'=>$request['ORDERID'],'txtId'=>$request['TXNID']];
            $data = ProductOrders::find($request->standby_id)->update(['status'=>0,'pay_key'=>json_encode($paid)]);
            if (is_null($data)) {
                return redirect(url('/api/v1/failed_payments?id='.$request['ORDERID']));
            }
            return view('payments/paytmWeb');

        } else if ('TXN_FAILURE' === $request['STATUS']) {
            return redirect(url('/api/v1/failed_payments?id='.$request['ORDERID']));
        }
    }
}
