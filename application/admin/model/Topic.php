<?php
/**
 * author   :  mzj
 * creatTime: 2017/4/14
 * description:
 */
namespace application\admin\model;
class  Topic extends \think\Model {


    function getList($where=''){
      return  $this ->where($where)->paginate(10);
    }


}