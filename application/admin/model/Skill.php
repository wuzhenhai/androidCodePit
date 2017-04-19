<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017-04-13
 * Time: 19:13
 */
namespace application\admin\model;

class Skill extends \think\Model
{

    function getList(){
       return  $this ->paginate(10);
    }


    public function edit($id,$data=array()){
        $res =  $this->where("id='".$id."'")->find();
        if($res){
            //后面的["tech_id" => $id]表示，更新这个id的数据
            return $this->save($data,["id" => $id]);
        }else{
            return false;
        }
    }

    /**
     * 获取技能信息
     * @param  int    $skill_id   技能id
     * @param  string $field   查询的字段名，默认为空，取全部
     * @return array           技能
     */
    public function getSkill($skill_id, $field= ''){
        $skill_info = $this->where('id ='. $skill_id)->field($field)->find();
        return $skill_info;
    }



}