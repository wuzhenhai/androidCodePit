<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-04-13
 * Time: 19:13
 */

namespace application\admin\model;


class TechGroup extends \think\Model
{

    function getList(){
       return  $this->select();
    }


    public function edit($id,$data=array()){
        $res =  $this->where("tech_id='".$id."'")->find();
        if($res){
            //后面的["tech_id" => $id]表示，更新这个id的数据
            return $this->save($data,["tech_id" => $id]);
        }else{
            return false;
        }
    }



}