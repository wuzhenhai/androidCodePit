<?php

// 应用公共文件
function p($str) {
    echo '<pre>';
    print_r($str);
}

function nodeTree($arr, $id = 0, $level = 0) {
    static $array = array();
    foreach ($arr as $v) {
        if ($v['parentid'] == $id) {
            $v['level'] = $level;
            $array[] = $v;
            nodeTree($arr, $v['id'], $level + 1);
        }
    }
    return $array;
}

/**
 * 数组转树
 * @param type $list
 * @param type $root
 * @param type $pk
 * @param type $pid
 * @param type $child
 * @return type
 */
function list_to_tree($list, $root = 0, $pk = 'id', $pid = 'parentid', $child = '_child') {
    // 创建Tree
    $tree = array();
    if (is_array($list)) {
        // 创建基于主键的数组引用
        $refer = array();
        foreach ($list as $key => $data) {
            $refer[$data[$pk]] = &$list[$key];
        }
        foreach ($list as $key => $data) {
            // 判断是否存在parent
            $parentId = 0;
            if (isset($data[$pid])) {
                $parentId = $data[$pid];
            }
            if ((string) $root == $parentId) {
                $tree[] = &$list[$key];
            } else {
                if (isset($refer[$parentId])) {
                    $parent = &$refer[$parentId];
                    $parent[$child][] = &$list[$key];
                }
            }
        }
    }
    return $tree;
}

/**
 * 下拉选择框
 */
function select($array = array(), $id = 0, $str = '', $default_option = '') {
    $string = '<select ' . $str . '>';
    $default_selected = (empty($id) && $default_option) ? 'selected' : '';
    if ($default_option)
        $string .= "<option value='' $default_selected>$default_option</option>";
    if (!is_array($array) || count($array) == 0)
        return false;
    $ids = array();
    if (isset($id))
        $ids = explode(',', $id);
    foreach ($array as $key => $value) {
        $selected = in_array($key, $ids) ? 'selected' : '';
        $string .= '<option value="' . $key . '" ' . $selected . '>' . $value . '</option>';
    }
    $string .= '</select>';
    return $string;
}

/**
 * 复选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值，多个用 '逗号'分割
 * @param $str 属性
 * @param $defaultvalue 是否增加默认值 默认值为 -99
 * @param $width 宽度
 */
function checkbox($array = array(), $id = '', $str = '', $defaultvalue = '', $width = 0, $field = '') {
    $string = '';
    $id = trim($id);
    if ($id != '')
        $id = strpos($id, ',') ? explode(',', $id) : array($id);
    if ($defaultvalue)
        $string .= '<input type="hidden" ' . $str . ' value="-99">';
    $i = 1;
    foreach ($array as $key => $value) {
        $key = trim($key);
        $checked = ($id && in_array($key, $id)) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="checkbox" ' . $str . ' id="' . $field . '_' . $i . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
        $i++;
    }
    return $string;
}

/**
 * 单选框
 * 
 * @param $array 选项 二维数组
 * @param $id 默认选中值
 * @param $str 属性
 */
function radio($array = array(), $id = 0, $str = '', $width = 0, $field = '') {
    $string = '';
    foreach ($array as $key => $value) {
        $checked = trim($id) == trim($key) ? 'checked' : '';
        if ($width)
            $string .= '<label class="ib" style="width:' . $width . 'px">';
        $string .= '<input type="radio" ' . $str . ' id="' . $field . '_' . $key . '" ' . $checked . ' value="' . $key . '"> ' . $value;
        if ($width)
            $string .= '</label>';
    }
    return $string;
}

/**
 * 字符串加密、解密函数
 *
 *
 * @param	string	$txt		字符串
 * @param	string	$operation	ENCODE为加密，DECODE为解密，可选参数，默认为ENCODE，
 * @param	string	$key		密钥：数字、字母、下划线
 * @param	string	$expiry		过期时间
 * @return	string
 */
function encry_code($string, $operation = 'ENCODE', $key = '', $expiry = 0) {
    $ckey_length = 4;
    $key = md5($key != '' ? $key : config('encry_key'));
    $keya = md5(substr($key, 0, 16));
    $keyb = md5(substr($key, 16, 16));
    $keyc = $ckey_length ? ($operation == 'DECODE' ? substr($string, 0, $ckey_length) : substr(md5(microtime()), -$ckey_length)) : '';

    $cryptkey = $keya . md5($keya . $keyc);
    $key_length = strlen($cryptkey);

    $string = $operation == 'DECODE' ? base64_decode(strtr(substr($string, $ckey_length), '-_', '+/')) : sprintf('%010d', $expiry ? $expiry + time() : 0) . substr(md5($string . $keyb), 0, 16) . $string;
    $string_length = strlen($string);

    $result = '';
    $box = range(0, 255);

    $rndkey = array();
    for ($i = 0; $i <= 255; $i++) {
        $rndkey[$i] = ord($cryptkey[$i % $key_length]);
    }

    for ($j = $i = 0; $i < 256; $i++) {
        $j = ($j + $box[$i] + $rndkey[$i]) % 256;
        $tmp = $box[$i];
        $box[$i] = $box[$j];
        $box[$j] = $tmp;
    }

    for ($a = $j = $i = 0; $i < $string_length; $i++) {
        $a = ($a + 1) % 256;
        $j = ($j + $box[$a]) % 256;
        $tmp = $box[$a];
        $box[$a] = $box[$j];
        $box[$j] = $tmp;
        $result .= chr(ord($string[$i]) ^ ($box[($box[$a] + $box[$j]) % 256]));
    }

    if ($operation == 'DECODE') {
        if ((substr($result, 0, 10) == 0 || substr($result, 0, 10) - time() > 0) && substr($result, 10, 16) == substr(md5(substr($result, 26) . $keyb), 0, 16)) {
            return substr($result, 26);
        } else {
            return '';
        }
    } else {
        return $keyc . rtrim(strtr(base64_encode($result), '+/', '-_'), '=');
    }
}


/**
 * 更通用的图片上传处理
 *
 * @param array $src_img 上传的图片资源，为$_FILES['filename']格式，一般地filename为img标签的name属性值
 * @param string $sub_path 图片保存子路径，以'/'开头，但不以'/'结尾，如设置友情链接logo图片子路径为'/other/link'，根路径为/Uploads/image
 * @param string $img_domain 图片域名，结尾无'/'，未设置则取配置项中IMG_DOMAIN值
 * @param int $limit_size 图片尺寸限制，如未设置默认2MB
 * @author zhengzhen
 * @return string $imgUrl
 * @todo 首先判断图片大小是否超出预设值，然后判断图片格式是否支持
 * @todo 创建相应路径并保存图片，转换图片路径为图片URL通过JSON输出到终端（一般为浏览器）
 *
 */
function upImageHandler($src_img, $sub_path, $img_domain = null, $limit_size = null)
{
    $tmpFile = $src_img['tmp_name'];
// echo "<pre>";
// var_dump($src_img);
// echo $tmpFile;
    $tmpFileSize = $src_img['size'];
    $maxSize = isset($limit_size) ? $limit_size : 2 * pow(1024, 2);
    if($tmpFileSize > $maxSize)
    {
        echo json_encode(array('status' => 0, 'msg' => '图片过大，请上传2MB以内大小图片！'));
        exit;
    }

    switch($src_img['type'])
    {
        case 'image/gif':
            $imgExt = '.gif';
            break;
        case 'image/jpeg':
        case 'image/pjpeg'://IE
            $imgExt = '.jpg';
            break;
        case 'image/png':
        case 'image/x-png'://IE
            $imgExt = '.png';
            break;
        default:
            break;
    }
    if(!isset($imgExt))
    {
        echo json_encode(array('status' => 0, 'msg' => '暂不支持该图片格式！'));
        exit;
    }

    $savePath = APP_PATH .'../public/Uploads/image' . $sub_path . '/' . date('Y-m');
    $saveFile = $savePath . '/' . date("YmdHis") . '_' . rand(10000, 99999) . $imgExt;

    //确认保存路径，没有则创建
    if(!is_dir($savePath))
    {
        if(!@mkdir($savePath, 0700, true))
        {
            echo json_encode(array('status' => 0, 'msg' => '上传目录创建失败！'));
            exit;
        }
    }
    //移动文件
    if(move_uploaded_file($tmpFile, $saveFile) === false)
    {
        echo json_encode(array('status' => 0, 'msg' => '图片上传失败！'));
        exit;
    }
//    if(!isset($img_domain))
//    {
//        $img_domain = C('IMG_DOMAIN');
//    }
    // $imgUrl = str_replace(APP_PATH . 'Uploads', $img_domain . '/Uploads', $saveFile);
    $imgUrl = str_replace(APP_PATH .'../public/', '/', $saveFile);
    //echo json_encode(array('status' => 1, 'img_url' => $imgUrl));
    //exit;
    return $imgUrl;
}


function utf8_strlen($str)
{
    $count = 0;
    for ($i = 0; $i < strlen($str); $i++)
    {
        $value = ord($str[$i]);
        if($value > 127)
        {
            $count++;
            if($value >= 192 && $value <= 223) $i++;
            elseif($value >= 224 && $value <= 239) $i = $i + 2;
            elseif($value >= 240 && $value <= 247) $i = $i + 3;
        }
        $count++;
    }
    return $count;
}
