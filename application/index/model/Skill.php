<?php
/**
 * author   :  mzj
 * createTime: 2017/5/18
 * description:
 */

namespace application\index\model;


use think\Model;

class Skill extends Model
{
    function __construct(){;
        $this->name="skill";
    }


    function getSkillById($id){
        $skill_id = $id ? intval($id) : 0;
        $skill_info = $this->where("id=" . $skill_id)->field('')->find();
        return $skill_info;
    }
}