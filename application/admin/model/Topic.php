<?php
/**
 * author   :  mzj
 * creatTime: 2017/4/14
 * description:
 */
namespace application\admin\model;
class  Topic extends \think\Model {


    function getList($where='',$page_count,$skill_type,$order='id desc'){
        if($skill_type!=0) {
            return $this->where($where)->order($order)->paginate($page_count, false, ['query' => ['skill_type' => $skill_type]]);
        }else{
            return $this->where($where)->order($order)->paginate($page_count);
        }
    }

    function getSkillList($where=""){
        $obj_skill = new Skill();
        return $obj_skill->where($where)->select();
    }

    function getTopicById($id){
        return $this->where("id='".$id."'")->find();
    }

    function edit($id,$data=array()){
        $res =  $this->where("id='".$id."'")->find();
        if($res){
            //后面的["tech_id" => $id]表示，更新这个id的数据
            return $this->save($data,["id" => $id]);
        }else{
            return false;
        }
    }

}