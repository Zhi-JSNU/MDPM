<!--Author: Zhi Create date:2021/7/9-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Search Files</title>
<style type="text/css">
body,div,p {margin:0 auto; padding:0;}
.taCenter {text-align:center;line-height:25px;}
.alarm {border:1px #ccc dashed; width:500px; margin-top:30px; padding:20px;}
.alarm b {color:#f00;}
.callback {border:1px #ccc dashed; text-align:left; width:400px; line-height:25px; margin-top:30px; padding:20px;}
.callback b {font-weight:normal;color:#f00;}
.rtFM {width:500px; height:30px; overflow:hidden; margin-top:20px;}
.rtFM a {width:160px; height:28px; line-height:28px; text-align:center; display:inline-block; border:1px #ccc solid; background-color:#f8f8f8; text-decoration:none;}
.rtFM a:hover {background-color:#fff;}
</style>
<script type="text/javascript" src="./js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("select[name='dstFolder']").change(function(){
		if($(this).val()=='0'){
			$("input[name='folder']").show();
			$("div[name='inFolder']").show();
			$("input[name='folder']").focus();
		}else{
			$("input[name='folder']").hide();
			$("div[name='inFolder']").hide();
		}
	});
});
function keygen(){
	document.upFile.action='?action=KeyGen';
	document.upFile.submit();
}
</script>
	</script>
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
<!--改动-->

<!-- particles.js container -->
<div id="particles-js" style="position: absolute;z-index: 0">
	<div style="position: absolute;z-index: 1;margin-top: 20px;width: 100%;text-align: center">
<?php
set_time_limit(0);
include('config.inc.php');
include('function.php');
//session_start();
start_session(1440);

$ta=getMillisecond();
//echo '本页面开始时间：'.$ta.'<br />';

if (empty($_SESSION["name"])) {
	header("location:fm.php");
	exit;
}

$username=strval($_SESSION["name"]);
$attribute=strval($_SESSION['attribute']);
$action=isset($_GET['action'])?strval($_GET['action']):'';
$keyword=isset($_POST['keyword'])?trim($_POST['keyword']):'';
$dstFolder=isset($_POST['dstFolder'])?trim($_POST['dstFolder']):'';

$folder=isset($_POST['folder'])?trim($_POST['folder']):'';

$checked='';
/*
if($att!='student' && $att!='teacher'){
	$att='teacher';
}
*/
//$readpermission=isset($_POST['readpermission'])?strval($_POST['readpermission']):'';
$host='http://10.20.22.150';

echo '<div style="text-align: right;font-size: 12pt;margin-right: 3%">Welcome:&nbsp<b>' . $username . '</b>(' . $attribute . '),&nbsp;&nbsp;<a href="?action=logout">Logout</a></div>';

echo '<br />';

$root=$_SERVER['DOCUMENT_ROOT'];
$upDir='files';
$lstDir='lstFiles';
$rootLstFile="$root/CPABE/$lstDir/root.lst";
$rootLstCpabeFile="$root/CPABE/$lstDir/root.lst.cpabe";
$dir=isset($_GET["dir"])?strval($_GET["dir"]):'root';
$dn=isset($_GET["dn"])?strval($_GET["dn"]):'ROOT';

//$newLstPath="$root/CPABE/$lstDir/$newFloder.lst.cpabe";
$folders=getFoldersByAttr($rootLstCpabeFile,$attribute);
$cpabes=getCpabesByAttr($rootLstCpabeFile,$attribute);
//echo getArrayTree($folders,0);exit;
$strFolder=substr(getArrayString($folders),0,-1);
$strCpabe=substr(getArrayString($cpabes),0,-1);
$arrFolder=explode(',',$strFolder);
$arrCpabe=explode(',',$strCpabe);
$lenArr=count($arrFolder);
$lstOptions='';
for($i=0;$i<$lenArr;$i++){
	if($dstFolder==$arrCpabe[$i]){
		$selected=" selected";
	}else{
		$selected='';
	}
	$lstOptions.='<option value='.$arrCpabe[$i].$selected.'>'.$arrFolder[$i].'</option>';
}

$strOptions='';
if(!empty($childrens) && $childrens!='err'){
	if($childrens){
		$lenChildren=count($childrens['folder']);
		for($i=0;$i<$lenChildren;$i++){
			if($dstFolder==$childrens['cpabe'][$i]){
				$selected=" selected";
			}else{
				if(!empty($dn) && !empty($dir)){
					if($dir==$childrens['cpabe'][$i]){
						$selected=" selected";
					}else{
						$selected='';
					}
				}else{
					$selected='';
				}
			}
			$strOptions.='<option value="'.$childrens['cpabe'][$i].'"'.$selected.'>'.$childrens['folder'][$i].'</option>';
		}
	}
}

?>

<div class="taCenter">
	<h1 style="font-size: 20pt">Examine Transferred Data System</h1>
	<?php
	if(!empty($dn) && !empty($dir)){
		echo '<form method="post" name="upFile" action="?action=search&dn='.$dn.'&dir='.$dir.'" enctype="multipart/form-data">';
	}else{
		echo '<form method="post" name="upFile" action="?action=search" enctype="multipart/form-data">';
	}
	?>
	<div style="text-align: center;margin-top: 1%;font-size: 13pt">Input the Attribute：<input type="text" name="keyword" value="<?=$keyword?>"><br /></div>
	<div style="text-align: center;margin-top: 1%;font-size: 13pt">Please choose the block that will be searched:
		<select name="dstFolder">
			<option value="root"<?php	if($dstFolder=='root'){echo ' selected';} ?>>Root</option>
			<?=$lstOptions?>
		</select><br /></div>
		<div name="inFolder"<?php if($dstFolder!='0'){echo ' style="display:none;"';} ?> style="text-align: center;margin-top: 1%;font-size: 13pt">Input the new block name:<input type="text" name="folder" /><br /></div>
		<br /><button type="submit" style="font-size: 16px; width: 180px; padding: 10px; background-color: #3498db; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Initiate Data Retrieval</button>

	</form>
</div>
			<p class="rtFM" style="width: 200px;height: 30px;font-size: 12pt; color: #fff;margin-right: auto;margin-left: auto"><a href="fm.php">Click to return</a></p>
<p>
<?php
?>

</p>

<div class="taCenter">
<?php
	$tb=getMillisecond();
	//echo '本页面结束时间：'.$tb.'<br />';
	echo '<br />the cost of loading page：'.round(($tb-$ta)/1000,3).' s';
if($action=='search'){
	$sTime=getMillisecond();
	//var_dump(empty($keyword) && strlen($keyword)==0);exit;
	//var_dump($keyword);exit;
	if($dstFolder=='0' && empty($folder)){
		echo '<p class="alarm"><b>Please input the block name.</b></p>';exit;
	}
	/*
	if(empty($readpermission)){
		echo '<p class="alarm"><b>Please input the readpermission.</b></p>';exit;
	}
	*/
	//echo $dstFolder;exit;
	$root=$_SERVER['DOCUMENT_ROOT'];
	$upDir='files';
	$lstDir='lstFiles';
	$rootLstFile="$root/CPABE/$lstDir/root.lst";
	$rootLstCpabeFile="$root/CPABE/$lstDir/root.lst.cpabe";

	//echo $dstFolder;exit;
	$dstLstCpabeFile="$root/CPABE/$lstDir/$dstFolder.lst.cpabe";

	$dstFolders=getFoldersByAttr($dstLstCpabeFile,$attribute);
	$dstCpabes=getCpabesByAttr($dstLstCpabeFile,$attribute);
	//print_r($dstFolders);exit;
	//echo getArrayTree($dstFolders,0);exit;
	$strDstFolder=substr(getArrayString($dstFolders),0,-1);
	$strDstCpabe=substr(getArrayString($dstCpabes),0,-1);
	$arrDstFolder=explode(',',$strDstFolder);
	$arrDstCpabe=explode(',',$strDstCpabe);
	$newDstFolder=array();
	$newDstCpabe=array();

    foreach ($arrDstFolder as $key => $val) {
        if (empty($val)) {
            continue;
        }
        $newDstFolder[] = $val;
    }
    foreach ($arrDstCpabe as $key => $val) {
        if (empty($val)) {
            continue;
        }
        $newDstCpabe[] = $val;
    }
	array_unshift($newDstCpabe,$dstFolder);
	$lenDstArr=count($newDstCpabe);

	$files='';
	for($i=0;$i<$lenDstArr;$i++){
		$lstCpabeFile="$root/CPABE/$lstDir/$newDstCpabe[$i].lst.cpabe";
		$temStr=getFilesByAttrAndKeyword($lstCpabeFile,$attribute,$keyword);
		if($temStr && $temStr!='Not Found.'){
			$files.=$temStr;
		}
	}

	if(empty($files)){
		$files='Not found.';
	}

	$eTime=getMillisecond();
	$diffTime=$eTime-$sTime;
	echo '<br />';
	echo 'The cost of this search：<font color="#9B30FF"><b>'.round($diffTime/1000,3).' s</b></font><br /><br />';
	echo '<div class="files" style="margin-top:20px;">'.$files.'</div>';


}
?>
</div>

	</div>
</div>
</body>

</html>