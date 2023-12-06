<!--Author: Zhi Create date:2021/7/1-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Meta Data Manger</title>
    <link type="text/css" rel="stylesheet" href="css/common.css"/>
    <link type="text/css" rel="stylesheet" href="css/style.css"/>
    <link rel="stylesheet" media="screen" href="particles.js-master/demo/css/style.css">
    <style type="text/css">
    </style>
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="particles.js-master/particles.js"></script>
    <script src="particles.js-master/demo/js/app.js"></script>

    <!-- stats.js -->
    <script src="particles.js-master/demo/js/lib/stats.js"></script>
    <script type="text/javascript">
        particlesJS.load('particles-js', 'particles.json', function() {
            console.log('particles.js loaded - callback');
        });
        $(document).ready(function () {
        });

        //改动---------------
        var count_particles, stats, update;
        stats = new Stats;
        stats.setMode(0);
        stats.domElement.style.position = 'absolute';
        stats.domElement.style.left = '0px';
        stats.domElement.style.top = '0px';
        document.body.appendChild(stats.domElement);
        count_particles = document.querySelector('.js-count-particles');
        update = function () {
            stats.begin();
            stats.end();
            if (window.pJSDom[0].pJS.particles && window.pJSDom[0].pJS.particles.array) {
                count_particles.innerText = window.pJSDom[0].pJS.particles.array.length;
            }
            requestAnimationFrame(update);
        };
        requestAnimationFrame(update);
    </script>
</head>
<body>
<!--韩 改动  加入particle.js-->

<!-- particles.js container -->
<div id="particles-js" style="position: absolute;z-index: 0">

    <?php
    include('config.inc.php');
    include('function.php');
    //echo $configArr[0][1]["username"];exit;


    set_time_limit(0);
    //session_start();
    start_session(1440);

    $action = isset($_GET['action']) ? strval($_GET['action']) : '';

    switch ($action) {
        case 'download':
            downFile();
            break;
        case 'del':
            delFile();
            break;
        case 'edit':
            editFile();
            break;
        case 'update':
            updateFile();
            break;
        case 'login':
            loginSystem($configArr[0]);
            break;
        case 'logout':
            logoutSystem();
            break;
        case 'read':
            readCpabe();
            break;
        default:
            listAll();
            break;
    }
    ?>
</div>
</body>
</html>
<?php
function downFile()
{
    $filename = isset($_GET['filename']) ? strval($_GET['filename']) : '';

    if (empty($filename)) {
        die('parameter missed.');
    } else {
        $fileDir = $_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . 'CPABE/files';
        $filePath = $fileDir . DIRECTORY_SEPARATOR . $filename . '.cpabe';
        //echo $filePath;exit;
        $handle = @fopen($filePath, "r");
        if ($handle) {
            Header("Content-type: application/octet-stream");
            Header("Content-Disposition: attachment; filename=" . $filename . '.file.cpabe');
            while (!feof($handle)) {
                echo fread($handle, 1024);
            }
        } else {
            echo 'The file "' . $filename . '" does not exist.<br />';
            echo '<a href="fm.php">click to return</a>';
        }
    }
}

function delFile()
{
    if (empty($_SESSION["name"])) {
        showLogin();
        exit;
    }
}

function editFile()
{
    if (empty($_SESSION["name"])) {
        showLogin();
        exit;
    }
}

function updateFile()
{
    if (empty($_SESSION["name"])) {
        showLogin();
        exit;
    }
}

function listAll()
{
    if (empty($_SESSION["name"])) {
        showLogin();
        exit;
    }
    $username = isset($_SESSION["name"]) ? strval($_SESSION["name"]) : '';
    $attribute = isset($_SESSION["attribute"]) ? strval($_SESSION["attribute"]) : '';
    $step = isset($_GET["step"]) ? intval($_GET["step"]) : '';
    $dir = isset($_GET["dir"]) ? strval($_GET["dir"]) : '';
    $dn = isset($_GET["dn"]) ? strval($_GET["dn"]) : '';
    $dp = isset($_GET["dp"]) ? strval($_GET["dp"]) : 'root';
    $root = $_SERVER['DOCUMENT_ROOT'];
    $upDir = 'files';
    $lstDir = 'lstFiles';
    //$fullFileName=$filename.'.cpabe';
    $rootLstFile = "$root/CPABE/$lstDir/root.lst";
    $rootLstCpabeFile = "$root/CPABE/$lstDir/root.lst.cpabe";
    //echo $rootLstFile;exit;


    if (empty($attribute)) {
        echo 'please relogin.<a href="?action=logout">relogin</a>';
        exit;
    }
    $line = 5;
    $header = readLstHeader($rootLstCpabeFile, $line);
    $cipher = readLstCipher($rootLstCpabeFile, strlen($header));
    //echo $cipher;exit;


    echo '<div style="text-align: right;font-size: 12pt;margin-right: 3%">Welcome:&nbsp<b>' . $username . '</b>(' . $attribute . '),&nbsp;&nbsp;<a href="?action=logout">Logout</a></div>';
    echo '<p>&nbsp;</p><input type="hidden" name="attribute" value="' . $attribute . '" />';
    if (strlen($cipher) > 0) {
        if (!empty($dn) && !empty($dir)) {
            echo '<p style="text-align: center;margin-top: 5%;font-size: 10pt"><a href="userUploadFile.php?dn=' . $dn . '&dir=' . $dir . '" class="btnLink" style="margin-right: 5%;width: 10%">Upload Data</a>&nbsp;&nbsp;<a href="createLst.php?dn=' . $dn . '&dir=' . $dir . '" class="btnLink" style="margin-left: 5%;margin-right: 5%;width: 10%">Create A New Block</a>&nbsp;&nbsp;<a href="searchFile.php" class="btnLink" target="_search" style="margin-left: 5%;width: 10%">Examine Data</a></p><br />';
        } else {
            echo '<p style="text-align: center;margin-top: 5%;font-size: 10pt"><a href="userUploadFile.php" class="btnLink" style="margin-right: 5%;width: 10%">Upload Data</a>&nbsp;&nbsp;<a href="createLst.php" class="btnLink" style="margin-left: 5%;margin-right: 5%;width: 10%">Create A New Block</a>&nbsp;&nbsp;<a href="searchFile.php" class="btnLink" target="_search" style="margin-left: 5%;width: 10%">Examine Data</a></p><br />';
        }
        echo '<h3>The files you can decrypt:</h3><h4>fileName/download/attribute/owner/read</h4><br />';
    } else {
        echo '<p style="text-align: center;margin-top: 5%;font-size: 10pt"><a href="userUploadFile.php" class="btnLink" style="margin-right: 5%;width: 10%">Upload New Data</a>&nbsp;&nbsp;<a href="createLst.php" class="btnLink" style="margin-left: 5%;margin-right: 5%;width: 10%">Create A New Block</a>&nbsp;&nbsp;<a href="searchFile.php" class="btnLink" target="_search" style="margin-left: 5%;width: 10%">Examine Data</a></p><br />';
    }

    if (empty($dir)) {
        $lstCpabeFile = "$root/CPABE/$lstDir/root.lst.cpabe";
        $dpDir = 'root';
    } else {
        $lstCpabeFile = "$root/CPABE/$lstDir/$dir.lst.cpabe";
        $dpDir = $dir;
    }

    $childrens = getChildrenByAttr($lstCpabeFile, $attribute);
    $files = getFilesByAttr($lstCpabeFile, $attribute);
    //var_dump($files);exit;
    //var_dump($childrens);exit;
    if ($childrens == 'err') {
        echo '<div class="lstFile" style="font-size: 11pt;margin-left: 10%"><a href="?action=show&dir=' . $dp . '">[ Return Parent Directory ]</a></div>';
        echo 'This folder is empty.';
        exit;
    } else {
        echo '<div style="margin-top: 5%;font-size: 11pt;margin-left: 10%">Local Storage/';
        if ($dn) {
            echo $dn . '/';
        }
        echo '</div>';
        if ($dn) {
            echo '<div class="lstFile" style="font-size: 11pt;margin-left: 10%"><a href="?action=show&dir=' . $dp . '">[ Return Parent Directory ]</a></div>';
        }
        if ($childrens) {
            if ($childrens['folder']) {
                $lenFolder = count($childrens['folder']);
                if ($lenFolder > 0) {
                    echo '<ul class="dirs">';
                    for ($i = 0; $i < $lenFolder; $i++) {
                        echo '<li><span>&nbsp;</span><a href="?action=show&dn=' . $childrens['folder'][$i] . '&dir=' . $childrens['cpabe'][$i] . '">' . $childrens['folder'][$i] . '</a></li>';
                    }
                    echo '</ul>';
                }
            }
        }
    }
    echo '<div class="files" style="font-size: 11pt;margin-left: 10%;padding: 0 0 0 0!important;">' . $files . '</div>';
    exit;


}

function loginSystem($array)
{
    $username = isset($_POST["name"]) ? strval($_POST["name"]) : '';
    $password = isset($_POST["password"]) ? strval($_POST["password"]) : '';
    if (empty($username)) {
        showLogin();
        exit;
    }
    if (empty($password)) {
        showLogin();
        exit;
    }

    /**********connect mysql,validate username.**************
     * $mysql_servername = "localhost";
     * $mysql_username = "root";
     * $mysql_password ="7026456";
     * $mysql_database ="cpabe";
     * mysql_connect($mysql_servername , $mysql_username , $mysql_password) or die("error");
     * mysql_select_db($mysql_database);
     * $query = mysql_query("SELECT * FROM info WHERE name ='".$username."' LIMIT 0,1");
     * if($query){
     * while($row = mysql_fetch_array($query)) {
     * $attribute=$row['attribute'];
     * $_SESSION["name"]=$username;
     * $_SESSION["attribute"]=$attribute;
     * }
     * }else{
     * echo 'The "'.$username.'" is not exist.Please login system again.<br /><a href="fm.php">return index</a>';
     * }
     * mysql_close();
     ************validate finished.**************************/

    $result = validateUserLogin($username, $password, $array);
    if ($result == 'right') {
        $attribute = findAttrByUsername($username, $array);
        $_SESSION["name"] = $username;
        $_SESSION["attribute"] = $attribute;
    }

    if (empty($_SESSION["name"])) {
        showLogin();
        exit;
    } else {
        header("location:?action=index");
    }
}

function _showLogin()
{
    echo '
	<center>
	<h2>Log In Page</h2>
	<body>

	<form name="login" action="login.php" method=post>
	name:             <input type=text name="name"><p>
	password:        <input type=password name="password"><p>
	<input name="log" type=submit value="login">
	</form>
	</body>
	</center>';
    exit;
}

function showLogin()
{
    echo '
	<div class="loginForm" style="position: absolute;z-index: 1;margin-left: 34%;margin-top: 10%;text-align: center">
		<img src="images/logo.png" style="height: auto;width: 80%;">
		<h2>MDPM verification</h2>
		<form method="post" name="loginForm" action="?action=login">
			UserName：<input type="input" name="name" placeholder="Your Username"><br />
			&nbsp;&nbsp;Password：<input type="password" name="password" placeholder="Your Password"><br />
			<input type="submit" value="Login" class="btnLogin" />
		</form>
		<div>
                <input type="button" value="Message" class="custom-button" />
                <input type="button" value="Forgot" class="custom-button" />

	    </div>
	</div>
	</body>
	</html>
	';
    exit;
}

function logoutSystem()
{
    $_SESSION = array();
    if (isset($_COOKIE[session_name()])) {
        setcookie(session_name(), '', time() - 86400, '/');
    }
    session_destroy();
    showLogin();
}

function readCpabe()
{
    $filename = isset($_GET['file']) ? strval($_GET['file']) : '';

    if (empty($filename)) {
        die('parameter missed.');
    } else {
        $fileDir = $_SERVER['DOCUMENT_ROOT'] . DIRECTORY_SEPARATOR . 'CPABE/files';
        $filePath = $fileDir . DIRECTORY_SEPARATOR . $filename . '.cpabe';
        //echo $filePath;exit;
        $attribute = isset($_SESSION["attribute"]) ? strval($_SESSION["attribute"]) : '';
        if (empty($attribute)) {
            echo 'Please relogin.';
            exit;
        } else {
            $content = readCpabeFile($filePath, $attribute);
            echo $content;
        }
    }
}

?>
