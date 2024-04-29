<?php
include 'partials/header.php';
if(!isset($_SESSION['user_is_admin'])){
    header("location: " . ROOT_URL . "logout.php");
    //destroy all sessions and redirect user to login page
    session_destroy();
}

if(isset($_GET['id'])){
    $id = filter_var($_GET['id'],FILTER_SANITIZE_NUMBER_INT);
    
    $query = "SELECT firstname,lastname,is_admin FROM users WHERE id='$id'";
    $result= mysqli_query($connection, $query);
    $user =  mysqli_fetch_assoc($result);
}
else{
    header('location: '. ROOT_URL.'admin/manage-users.php');
}
?>  

<!--=================================== END OF NAV ==================================-->

<section class="form__section"> 
        <div class="container form__section-container">
            
            <h2>Edit User</h2>
            <!-- <div class="alert__message error">
                <p>this is an error message</p>
            </div> -->
            <form action="<?=ROOT_URL ?>admin/edit-user-logic.php" enctype="multipart/form-data" method="post">
            <input type="hidden" value="<?=$id?>" name='id'>
                <input type="text" value="<?= $user['firstname']?>" name="firstname" placeholder="First Name">
                <input type="text" value="<?= $user['lastname']?>" name="lastname" placeholder="Last Name">
                <select name="userrole">
                    <option value="0">Author</option>
                    <option <?= $user['is_admin'] ? 'selected' : '' ?> value="1">Admin</option>
                </select>
            
                <button type="submit" name='submit' class="btn">Update User</button>
            </form>
        </div>
</section>
