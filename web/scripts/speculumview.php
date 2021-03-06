<?php

class xDataChunk {
	var $sName;
	var $iStart;
	var $iLength;
}
$arChunk[4] = new xDataChunk();

$arChunk['0']->sName = 'doc';
$arChunk['0']->iStart = 0;
$arChunk['0']->iLength = 4;

$arChunk['1']->sName = 'obj';
$arChunk['1']->iStart = 4;
$arChunk['1']->iLength = 3;

/*
 * build_url
 *
 * parameters:
 *   view: array of validated, secure 'view' integer strings. 
 *   index: current element of view array. (I can't use foreach since I need access
 *      to every array element to build an href every time.)
 *   item: item number, in packed view string, that this link changes. 
 *   new_value: new value for that item number. (no validation yet.)
 *
 * return value:
 *   url string, from 'http' including one or two parameters. enclose this in quotes in an href. 
 */

function build_url($view, $index, $item, $new_value) {
	$url = 'http://speculum.lib.uchicago.edu/scripts/view.php';
	for ($i = 0; $i < count($view); $i++) {
		if ($i == 0) {
			$url .= '?';
		} else {
			$url .= '&';
		}
		if ((int)$index != $i) {
			/* pass the other view's url parameter as is. */ 
			$url .= 'view' . ($i + 1) . '=' . $view[$i];
		} else {
			/* modify a part of this view's url parameter. */
			$url .= 'view' . ($i + 1) . '=' . build_url_chunk($view[$i], $item, $new_value);
		}
	}
	return $url;
}

function split_url($view, $index) {
	$url = 'http://speculum.lib.uchicago.edu/scripts/view.php';
	$url .= '?view1=' . $view[$index];
	$url .= '&view2=' . $view[$index];
	return $url;
}

function join_url($view, $index) {
	$url = 'http://speculum.lib.uchicago.edu/scripts/view.php';
	$url .= '?view1=' . $view[$index];
	return $url;
}

function build_url_chunk($v, $item, $new_value) {
	global $arChunk;
	if ($arChunk[$item] == null) {
		print "error";
		return $v;
	}
	$chunk = '';
	$chunk .= substr($v, 0, $arChunk[$item]->iStart);
	$chunk .= $new_value;
	$chunk .= substr($v, $arChunk[$item]->iStart + $arChunk[$item]->iLength, strlen($v));
	return $chunk;
}

/*
 * firefox uses embed, explorer uses object 
 */
function content_builder($view, $i) {
	global $arManuscripts;
	global $currentManuscript;
	global $zoomifyX;
	global $zoomifyY;
	global $zoomifyZoom;
	loadCurrentDoc(get_doc($view, $i));

	$flashVars = '';
	$flashVars .= 'zoomifyImagePath1=http://speculum.lib.uchicago.edu/images/zoomify/speculum-';
	$flashVars .= get_doc($view, 0);
	$flashVars .= '-001';
	$flashVars .= '&zoomifyImageIndex=' . $i;
	$flashVars .= '&zoomifyX=' . $zoomifyX;
	$flashVars .= '&zoomifyY=' . $zoomifyY;
	$flashVars .= '&zoomifyZoom=' . $zoomifyZoom;
?>	
	<div class="content">
		<div style="text-align:center;">
		<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
		codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0"
		width="100%"
		height="100%"
		id="test-zoomify2"
		align="middle">
			<param name="allowScriptAccess" value="sameDomain" />
			<param name="movie"
value="http://speculum.lib.uchicago.edu/scripts/test-zoomify24.swf" />
			<param name="quality" value="high" />
			<param name="bgcolor" value="#f4f5f7" />
			<param name="FlashVars" value="<?php echo $flashVars; ?>" />
			<embed
src="http://speculum.lib.uchicago.edu/scripts/test-zoomify24.swf"
				FlashVars="<?php echo $flashVars; ?>"
				quality="high"
				bgcolor="#f4f5f7"
				width="100%"
				height="100%"
				name="test-zoomify2"
				align="middle"
				allowScriptAccess="sameDomain"
				type="application/x-shockwave-flash"
				pluginspage="http://www.macromedia.com/go/getflashplayer" />
		</object>
		</div>
	</div><!--content-->
<?php
}

function split_builder($view, $i) {
	if (count($view) == 1) {
?>
		<div class="pagesplit"><a href='<?php echo split_url($view, $i); ?>'><img src="../images/page-view-split.gif"/></a></div>
<?php
	}
	if (count($view) == 2) {
?>
		<div class="pagesplit"><a href='<?php echo join_url($view, $i); ?>'><img src="../images/page-view-join.gif"/></a></div>
<?php
	}
}
?>
