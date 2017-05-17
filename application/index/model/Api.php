<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-05-16
 * Time: 15:00
 */

namespace application\index\model;


use think\Model;

class Api  extends Model
{

    public $key = "jfoii#56flkdji.883-=";
    /**
     * 验证必要参数合法性
     * @author 姜伟
     * @param void
     * @return void
     * @todo 验证必要参数合法性
     */
    function getRequiredParams()
    {
        $params = array(
            array(
                'field'		=> 'appid',
                'type'		=> 'string',
                'required'	=> true,
                'miss_code'	=> 41008,
                'empty_code'=> 44008,
                'type_code'	=> 45008,
                'func'		=> 'checkAppid',
                'func_code'	=> 47008,
            ),
            array(
                'field'		=> 'api_name',
                'required'	=> true,
                'miss_code'	=> 41009,
                'empty_code'=> 44009,
                'type_code'	=> 45009,
                'func'		=> 'checkApiName',
                'func_code'	=> 47009,
            ),
            array(
                'field'		=> 'token',
                'min_len'	=> 32,
                'max_len'	=> 32,
                'type'		=> 'string',
                'required'	=> true,
                'len_code'	=> 40010,
                'miss_code'	=> 41010,
                'empty_code'=> 44010,
                'type_code'	=> 45010,
            ),
            array(
                'field'		=> 'PHPSESSID',
                'type'		=> 'string',
                #'required'	=> true,
                #'miss_code'	=> 41011,
                'type_code'	=> 45011,
                'func'		=> 'checkPHPSESSID',
                'func_code'	=> 40011,
            ),
        );

        return $params;
    }


    /**
     *
     * @author 姜伟
     * @param int $code 返回码
     * @param array $data 返回结果
     * @param string $error_msg 错误说明
     * @return
     * @todo
     */
    static function returnResult($code = 0, $data = array(), $error_msg = '')
    {
        if ($code)
        {
            $return_arr = array(
                'code'		=> $code,
                'error_msg'	=> $error_msg
            );

            exit(json_encode($return_arr));
        }

        $return_arr = array(
            'code'	=> 0,
            'data'	=> $data,
        );
        exit(json_encode($return_arr));	//上线后开启
//        print_r($return_arr);	//调试时开启
//        exit;
    }

    /**
     * 验证api_name合法性
     * @author 姜伟
     * @param string $api_name 接口名
     * @param int $func_code 返回码
     * @return 成功返回true，失败退出返回错误码
     * @todo 验证api_name合法性
     */
    static function checkApiName($api_name, $func_code)
    {
        if(!preg_match("/^[a-zA-Z]{3,10}\.[a-zA-Z]{3,16}\.[a-zA-Z]{4,32}$/", $api_name))
        {
            self::returnResult($func_code, null, '参数api_name格式不正确');
        }
    }


    /**
     * 判断特定API参数合法性
     * @author 姜伟
     * @param array $params 参数列表
     * @return boolean
     * @todo 判断特定API参数合法性，遍历$params，根据其设置的条件判断参数是否合法
     */
    public function checkParamsValid($params = array())
    {
        $new_params = array();
        foreach ($params as $k => $v) {
            //是否传值
            if (isset($v['required']) && $v['required'] && !isset($_REQUEST[$v['field']])) {
                Api::returnResult($v['miss_code'], null, '缺少' . $v['field'] . '参数');
            }
            $param = input($v['field']);

            //是否为空
            if (isset($v['required']) && $v['required'] && $param == '' && isset($v['empty_code'])) {
                Api::returnResult($v['empty_code'], null, '参数' . $v['field'] . '为空');
            }

            //类型
            if (isset($v['required']) && $v['required'] && $v['type'] && $v['type'] == 'file') {
                //文件，上传之
                $user_id = intval(session('user_id'));
//                $param   = uploadImage($_FILES[$v['field']], '/user/' . $user_id);
//                log_file('file_data: file_path = ' . $param);
            } elseif (isset($_REQUEST[$v['field']]) && isset($v['required']) && $v['required'] && $v['type'] && $v['type'] != 'string') {
                if ($v['type'] == 'int' || $v['type'] == 'float') {
                    //是否为数字
                    if (!Api::checkNumeric($param)) {
                        //不是则退出返回错误码
                        Api::returnResult($v['type_code'], null, '参数' . $v['field'] . '必须为数字');
                    }
                }
            }

            if (isset($_REQUEST[$v['field']])) {
                //最小长度
                if (isset($v['min_len']) && $v['type'] == 'string') {
                    //字符串最小长度
                    if (utf8_strlen($param) < $v['min_len']) {
                        //字符串长度小于最小长度，报错退出
                        Api::returnResult($v['len_code'], null, '参数' . $v['field'] . '长度不得小于' . $v['min_len'] . '位');
                    }
                }

                //最大长度
                if (isset($v['max_len']) && $v['type'] == 'string') {
                    //字符串最大长度
                    if (utf8_strlen($param) > $v['max_len']) {
                        //字符串长度大于最大长度，报错退出
                        Api::returnResult($v['len_code'], null, '参数' . $v['field'] . '长度不得大于' . $v['max_len'] . '位');
                    }
                }

                //当类型为整型或浮点型时，min_len的意义为最小数值
                if (isset($v['min_len']) && ($v['type'] == 'int' || $v['type'] == 'float')) {
                    //数字最小值
                    if ($param < $v['min_len']) {
                        //数字长度小于最小值，报错退出
                        Api::returnResult($v['len_code'], null, '参数' . $v['field'] . '最小值不得小于' . $v['min_len']);
                    }
                }

                //当类型为整型或浮点型时，max_len的意义为最大数值
                if (isset($v['max_len']) && ($v['field'] == 'type' || $v['type'] == 'float')) {
                    //数字最大值
                    if ($param > $v['max_len']) {
                        //数字长度大于最大值，报错退出
                        Api::returnResult($v['len_code'], null, '参数' . $v['field'] . '最大值不得大于' . $v['max_len']);
                    }
                }

                //函数验证
                if (isset($v['func']) && $v['func']) {
                    Api::$v['func']($param, $v['func_code']);
                }

                $new_params[$v['field']] = $param;
            }
        }
        #echo "<pre>";
        #print_r($new_params);
        #static $i = 0;
        #$i ++;
        #if ($i == 2)
        #{
        #die;
        #}

        return $new_params;
    }


    /**
     * 检验字段fieldName的值value是否是number
     *
     **/
    public static function checkNumeric($value,$fieldName='')
    {
        if(!is_numeric($value))
        {
            return false;
        }

        return true;
    }

    /**
     * 验证appid合法性
     * @author 姜伟
     * @param string $appid
     * @param int $func_code 返回码
     * @return 成功返回true，失败退出返回错误码
     * @todo 验证appid合法性
     */
    static function checkAppid($appid, $func_code)
    {
        $arr = array('cheqishiandroidappid@U*NDd8vK1^2pKh', 'cheqishiiosappid@u8ms@nsN2G8M2', '1');
        if (!in_array($appid, $arr))
        {
            self::returnResult($func_code, null, 'appid错误');
        }
    }


    /**
     * 验证PHPSESSID合法性
     * @author 姜伟
     * @param string $PHPSESSID 接口名
     * @param int $func_code 返回码
     * @return 成功返回true，失败退出返回错误码
     * @todo 验证PHPSESSID合法性
     */
    static function checkPHPSESSID($PHPSESSID, $func_code)
    {
        $api_name = explode('.', I('request.api_name'));
        $api_name = $api_name[2];
        if ($api_name != 'login' && $api_name != 'register' && $api_name != 'checkMobileRegistered' && $api_name != 'sendVerifyCode' && $api_name != 'findPassword'&& $api_name != 'findPasswordBySms' && $api_name != 'checkVerifyCodeValid' && $api_name != 'signin' && $api_name != 'signup' && $api_name != 'getPayInfoByOrderId')
        {
            if(!session('user_id'))
            {
                self::returnResult($func_code, null, '无效的PHPSESSID');
            }
        }
    }

    /**
     * 获取sign
     * @author 姜伟
     * @param array $params 请求参数列表
     * @return string sign
     * @todo 排序，组成请求字符串后，连接key进行MD5加密，返回
     */
    function generateSign($data)
    {
        ksort($data);

        $sign = '';
        foreach($data as $key => $val)
        {
            if($key != 'token')
            {
                $sign .= "&$key=$val";
            }
        }

        $sign = md5(substr($sign, 1) . $this->key);
        return $sign;
    }

    function checkPriv()
    {
        $data = $_REQUEST;
        unset($data['_URL_']);
        ksort($data);

        $sign = '';
        foreach($data as $key => $val)
        {
            if($key != 'token')
            {
                $sign .= "&$key=$val";
            }
        }
        #echo substr($sign,1);
        #die;

        if($data['token'] != md5(substr($sign,1) . $this->key))
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    /**
     *
     * @author 姜伟
     * @param
     * @return
     * @todo
     */
    function permissionDeny()
    {
        self::returnResult(40001, null, '访问令牌无效，key不正确或加密方式不对');
    }


}