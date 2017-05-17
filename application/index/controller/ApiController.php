<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/6
 * Time: 17:05
 */

namespace application\index\controller;


/**
 * 请求地址  http://ServerHost/index/api/api?api_name=abc.user.getUserList&abc=123
 * abc可以自定义
 * user控制器名称
 * getUserList方法名
 * & 后面都是参数
 */
use application\index\model\Api;
class ApiController extends BaseApiController
{
    private $api_type;
    private $api_name;
    private $params;

    public function _initialize()
    {
        parent::_initialize();
    }

    function api(){
        $params = $_REQUEST;
        $this->parseRequest();
        $res = $this->callApi($params);
        Api::returnResult(0,$res);
    }


    /**
     * 解析请求的接口类型和接口名
     * @author 姜伟
     * @param void
     * @return void
     * @todo 解析请求的接口类型和接口名，并赋值到$this->api_type和$this->api_name字段
     */
    public function parseRequest()
    {
        $requests       = explode('.', input('request.api_name'));
//        print_r($requests);
//        exit();
        //引入命名空间后的修改
        $this->api_type = __NAMESPACE__."\\".ucfirst($requests[1])."ApiController";
        $this->api_name = $requests[2];
    }

    /**
     * 调用接口
     * @author 姜伟
     * @param void
     * @return void
     * @todo 调用接口，$this->api_type为类名，$this->api_name为方法名
     */
    public function callApi($params)
    {
        $obj       = new $this->api_type();
        //var_dump($obj);
        $func_name = $this->api_name;
        return $obj->$func_name($params);
    }




}
