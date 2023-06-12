<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$item_name = $_POST['itemname'];
$item_desc = $_POST['itemdesc'];
$item_price = $_POST['itemprice'];
$item_qty = $_POST['itemqty'];
$item_type = $_POST['type'];
$user_id = $_POST['userid'];
$item_lat = $_POST['latitude'];
$item_long = $_POST['longitude'];
$item_state = $_POST['state'];
$item_locality = $_POST['locality'];
$images = json_decode($_POST['images']);

$sqlinsert = "INSERT INTO `tbl_items`(`user_id`, `item_name`, `item_type`, `item_desc`, `item_price`, `item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`) VALUES ('$user_id','$item_name','$item_type','$item_desc','$item_price','$item_qty','$item_lat','$item_long','$item_state','$item_locality')";

if ($conn->query($sqlinsert) === TRUE) {
    $item_id = mysqli_insert_id($conn);
    $response = array('status' => 'success', 'data' => null);
    
    $images = json_decode($_POST['images']); // Decoding the JSON array of images
    
    // Loop through the images and save them
    for ($i = 0; $i < count($images); $i++) {
        $image = $images[$i];
        $decoded_string = base64_decode($image);
        $filename = $item_id . '_' . ($i + 1) . '.png'; // Generating a unique filename for each image
        $path = '../assets/images/' . $filename;
        file_put_contents($path, $decoded_string);
    }
    
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>