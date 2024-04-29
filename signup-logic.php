<?php
require 'config/database.php';
session_start();
// get signup form data if signup button was clicked

if(isset($_POST['submit']))
{
    $firstname = filter_var($_POST['firstname'],FILTER_SANITIZE_FULL_SPECIAL_CHARS);
    $lastname = filter_var($_POST['lastname'],FILTER_SANITIZE_FULL_SPECIAL_CHARS);
    $username = filter_var($_POST['username'],FILTER_SANITIZE_FULL_SPECIAL_CHARS);
    $email = filter_var($_POST['email'],FILTER_VALIDATE_EMAIL);
    $createpassword = filter_var($_POST['createpassword'],FILTER_SANITIZE_FULL_SPECIAL_CHARS);
    $confirmpassword = filter_var($_POST['confirmpassword'],FILTER_SANITIZE_FULL_SPECIAL_CHARS);
    $avatar = $_FILES['avatar'];
    // echo $firstname, $lastname, $username, $email, $confirmpassword, $createpassword;
    // var_dump($avatar); // we cant store the avatar in array

    // validate the input values
    if(!$firstname){
        $_SESSION['signup'] = 'please enter your First Name';
    }
    elseif(!$lastname){
        $_SESSION['signup'] = 'please enter your Last Name';
    }
    elseif(!$username){
        $_SESSION['signup'] = 'please enter your User Name';
    }
    elseif(!$email){
        $_SESSION['signup'] = 'please enter your valid Email';
    }
    elseif(strlen($createpassword) < 8 || strlen($confirmpassword)<8){
        $_SESSION['signup'] = 'password should be 8+ characters';
    }
    elseif(!$avatar['name']){
        $_SESSION['signup'] = 'please add avatar'; 
    }
    else{
        if($confirmpassword !== $createpassword){
            $_SESSION['signup'] =" passwords do not match";
        }
        else{
                $hashed_password = password_hash($createpassword, PASSWORD_DEFAULT);
                // echo"this is hashed: $hashed_password this is normal: $createpassword";
                // echo  "hashed: ".$hashed_password;
                // echo "<br>";
                // echo "Normal: ".$createpassword;
                $user_check_query = "SELECT * FROM users WHERE username= '$username' OR email='$email'";
                $user_check_query = mysqli_query($connection, $user_check_query);
                if(mysqli_num_rows($user_check_query)>0){
                    $_SESSION['signup'] = "Username or Email already exists";
                } 
                else{
                    // image can be have duplicate filename so we replace it with time
                    $time =  time();
                    $avatar_name = $ime . $avatar['name'];
                    $avatar_tmp_name = $avatar['tmp_name'];
                    $avatar_destination_path = 'images/'.$avatar_name;
                    $allowed_files = ['png','jpg','jpeg']; // only this will be allowed
                    $extention = explode('.',$avatar_name);
                    $extention = end($extention);
                    if(in_array($extention,$allowed_files)){
                            // image is not too large(3mb+)
                            if($avatar['size']<3000000)
                            {
                                move_uploaded_file($avatar_tmp_name, $avatar_destination_path);
                            }
                            else{
                                $_SESSION['signup'] = 'Image should be less than 3 mb'; 
                            }
                    }
                    else{
                        $_SESSION['signup']= 'file should be png, jpg, jpeg';
                    }
                }
        }   
    }
    if(isset($_SESSION['signup']))
    {
        $_SESSION['signup-data'] = $_POST;
        header( 'location: '. ROOT_URL.'signup.php');
        die();
    }
    else{
        // $insert_user_query = "INSERT INTO users (firstname,lastname, username,email, password, avatar, is_admin) values('$firstname','$lastname','$username','$email','$hashed_password','$avatar_name',0";

        $insert_user_query = "INSERT INTO users set firstname = '$firstname', lastname = '$lastname', username = '$username',email = '$email', password = '$hashed_password', avatar = '$avatar_name', is_admin = 0";
        $insert_user_result = mysqli_query($connection,$insert_user_query);
        if(!mysqli_errno($connection)){
            $_SESSION['signup-success'] = "registration successfull. please Login";
            header('location: '.ROOT_URL.'signin.php');
            die();
        }
    }

}

else{
    // if button was not clicked, bounce back to signup page     
    header('location:'.ROOT_URL . 'signup.php');
    die();
}