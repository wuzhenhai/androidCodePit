<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\model;


class Article extends \think\Model {

    public function getList($where="",$search=[]) {
        $res = $this->where($where)->order('id', 'desc') ->paginate(10,false, ['query' => $search]);
        $res = $this->getListData($res);
//        var_dump($res);
//        exit();
        return $res;
    }


    //拼装topic
    public function getListData($article_list)
    {
        foreach ($article_list as $k => $v) {

            //技能
            $skill_obj = new Skill();
            $skill_info = $skill_obj->getSkill($v['skill_id'], 'skill_name');
            $article_list[$k]['skill_name'] = $skill_info['skill_name'];

            //专题名
            $topic_obj = new Topic();
            $topic_info = $topic_obj->getTopicById($v['topic_id']);
            $article_list[$k]['topic_name'] = $topic_info['topic_name'];
        }
        return $article_list;
    }

    function edit($data=array()){
        $res =  $this->where("id='".$data["id"]."'")->find();
        if($res){
            //后面的["tech_id" => $id]表示，更新这个id的数据
            return $this->save($data,["id" => $data["id"]]);
        }else{
            return false;
        }
    }

}
