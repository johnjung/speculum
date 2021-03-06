<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<?php
/* 
 * call this script with one long-form speculum number and one short form.
 * This is so if someone wants to compare something with one of 
 * speculum-0295-002, 003 or 004 they can. (they just can't compare those
 * with each other.)
 *
 * view2.php?id1=speculum-0001-001&id2=A1
 */

$clean = array();

/*
 * CLEAN SPECULUM PIDS. THE PID WILL EITHER HAVE DASHES OR IT WON'T.
 * IF IT HAS NO DASHES, IT CAN BE A 'A1' OR '994' OR '0500' STYLE
 * PID. IF IT HAS DASHES, IT MUST BE 'SPECULUM-0295-003' STYLE.
 */

function cleanPid($get) {
	$parts = explode('-', $get);

	// 'A1', '994', '0500'
	if (count($parts) == 1) {
		$numstr = ltrim($parts[0], " a..zA..Z");
		if ((int)$numstr > 994 || (int)$numstr < 1) {
			return 'speculum-0001-001';
		}
		if (!(strlen($numstr) <= 4 && ctype_digit($numstr))) {
			return 'speculum-0001-001';
		}
		$numpadded = "speculum-" . str_pad($numstr, 4, "0", STR_PAD_LEFT) . "-001";
		return $numpadded;
	}

	// 'speculum-0295-003'
	if (count($parts) != 3) {
		return 'speculum-0001-001';
	}
	if ($parts[0] != 'speculum') {
		return 'speculum-0001-001';
	}
	if (!(strlen($parts[1]) == 4 && ctype_digit($parts[1]))) {
		return 'speculum-0001-001';
	}
	if (!(strlen($parts[2]) == 3 && ctype_digit($parts[2]))) {
		return 'speculum-0001-001';
	}
	return implode('-',$parts);
}

$clean['id1'] = 'speculum-0001-001';
if (isset($_GET['id1'])) {
	$clean['id1'] = cleanPid($_GET['id1']);
}
$imagepath1 = '../images/zoomify/' . $clean['id1'];

$clean['id2'] = 'speculum-0001-001';
if (isset($_GET['id2'])) {
	$clean['id2'] = cleanPid($_GET['id2']);
}
$imagepath2 = '../images/zoomify/' . $clean['id2'];
?>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Pragma" content="no-cache">
<title>The Speculum Romanae Magnificentiae</title>
<style type="text/css">
* {
	border: 0;
	margin: 0;
	padding: 0;
}
html {
	height: 100%;
}
body {
	background: #ffffff;
	height: 100%;
	width: 100%;
}
#view1 {
	float: left;
	height: 100%;
	width: 49.5%;
}
#view2 {
	float: right;
	height: 100%;
	width: 49.5%;
}
</style>
<script src="/scripts/ga.js"></script>
</head>
<body onLoad="javascript:window.focus()">
<div id="view1" style="background: yellow;">
<object
 classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
 codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
 width="100%"
 height="100%"
 id="zoomifyviewer"
 align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="movie" value="zoomifyviewer.swf" />
	<param name="flashVars" value="imagepath=<?php echo $imagepath1; ?>" />
	<param name="quality" value="high" />
	<param name="scale" value="noscale" />
	<param name="bgcolor" value="#ffffff" />
	<embed
	 src="zoomifyviewer.swf"
	 flashvars="imagepath=<?php echo $imagepath1; ?>"
	 quality="high"
	 scale="noscale"
	 bgcolor="#ffffff"
	 width="100%"
	 height="100%"
	 name="zoomifyviewer"
	 align="middle"
	 allowScriptAccess="sameDomain"
	 type="application/x-shockwave-flash"
	 pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
</div>
<div id="view2" style="background: green;">
<object
 classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
 codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
 width="100%"
 height="100%"
 id="zoomifyviewer"
 align="middle">
	<param name="allowScriptAccess" value="sameDomain" />
	<param name="movie" value="zoomifyviewer.swf" />
	<param name="flashVars" value="imagepath=<?php echo $imagepath2; ?>" />
	<param name="quality" value="high" />
	<param name="scale" value="noscale" />
	<param name="bgcolor" value="#ffffff" />
	<embed
	 src="zoomifyviewer.swf"
	 flashvars="imagepath=<?php echo $imagepath2; ?>"
	 quality="high"
	 scale="noscale"
	 bgcolor="#ffffff"
	 width="100%"
	 height="100%"
	 name="zoomifyviewer"
	 align="middle"
	 allowScriptAccess="sameDomain"
	 type="application/x-shockwave-flash"
	 pluginspage="http://www.macromedia.com/go/getflashplayer" />
</object>
</div>
</body>
</html>

