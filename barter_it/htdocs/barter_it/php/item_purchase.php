<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php"); // Include your database connection file or configure the database connection

if (isset($_POST['item_id']) && isset($_POST['user_id'])) {
    $itemId = $_POST['item_id'];
    $userId = $_POST['user_id'];

    // Fetch the item's quantity from the database
    $query = "SELECT item_qty FROM tbl_items WHERE item_id = '$itemId'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $itemQty = $row['item_qty'];

        // Check if the item is available and its quantity is greater than 0
        if ($itemQty > 0) {
            // Update the item's quantity
            $newQty = $itemQty - 1;
            $updateQuery = "UPDATE tbl_items SET item_qty = '$newQty' WHERE item_id = '$itemId'";
            if ($conn->query($updateQuery) === TRUE) {
                // Item quantity updated successfully
                // You can perform additional actions like recording the purchase in another table, etc.

                // Return a success response to the Flutter app
                $response = array('status' => 'success', 'message' => 'Item purchased successfully');
                sendJsonResponse($response);
            } else {
                // Error occurred while updating the item's quantity
                $response = array('status' => 'error', 'message' => 'Failed to update item quantity');
                sendJsonResponse($response);
            }
        } else {
            // Item is out of stock
            $response = array('status' => 'error', 'message' => 'Item is out of stock');
            sendJsonResponse($response);
        }
    } else {
        // Failed to fetch item details
        $response = array('status' => 'error', 'message' => 'Failed to fetch item details');
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
    die();
}
?>