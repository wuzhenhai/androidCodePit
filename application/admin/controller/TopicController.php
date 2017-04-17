<?php
namespace application\admin\controller;
use application\admin\model\Topic;
use think\Db;

/**
 * author   :  mzj
 * creatTime: 2017/3/9
 * description:
 */
class TopicController extends CommonController {

    public function index()
    {
        $where = "";
        $page_count = 10;//每页显示的数量
        $skill_id = 0;

        //设置技能类别
        if(isset($_REQUEST['skill_type'])){
            $skill_id = $_REQUEST['skill_type'];
            if($skill_id!=0) {
                $where = "skill_id='" . $skill_id . "'";
            }
            $this->assign("skill_type",$skill_id);
        }

        $topic_obj=new Topic();

        $lists=$topic_obj->getList($where,$page_count,$skill_id);
        $page = $lists->render();//分页
        //获取技能列表
        $select_skill_list = $topic_obj->getSkillList();
        //var_dump($select_topic_list);
        $this->assign("lists",$lists);
        $this->assign("page",$page);
        $this->assign("skill_list",$select_skill_list);
        return $this->fetch();
    }

//    public function ajax_get_topic(){
//        $topic_id = isset($_POST['topic_id'])?$_POST['topic_id']:0;
//        $topic_obj = new Topic();
//        $topic = $topic_obj->getTopicById($topic_id);
//        if($topic){
//            $resp['success'] = true;
//            $resp['code'] = 0;
//            $resp['data'] = json_encode($topic);
//            exit(json_encode($resp));
//        }else{
//            $resp['success'] = false;
//            $resp['code'] = 1;
//            $resp['msg'] = "添加失败";
//            exit(json_encode($resp));
//        }
//    }

    /**
     * 添加
     */
    public function add(){
        $data = input();
        //exit(print_r($data));
        $topic_obj = new Topic();
        if(!empty($data['topic_name'])){
            $r = $topic_obj-> allowField(true)->save($data);
            $resp = array();
            if($r){
                //稍微规范点的返回
                $resp['success'] = true;
                $resp['code'] = 0;
                exit(json_encode($resp));
            }else{
                $resp['success'] = false;
                $resp['code'] = 1;
                $resp['msg'] = "添加失败";
                exit(json_encode($resp));
            }
        }
    }

    /**
     * 编辑
     */
    function edit(){
        $data = input();
        $topic_obj = new Topic();
        $r = $topic_obj->edit($data['id'],$data);
        if($r){
            exit("success");
        }else {
            exit("failure");
        }
    }

    /**
     * 删除
     */
    public function del()
    {
        $data = input();
        if (empty($data['id'])){
            //$this->error('id缺失');
            exit("id缺失");
        }
        $res = Db::name('topic')->where($data)->delete();
        if ($res) {
            exit("success");
        } else {
            exit("failure");
        }
    }
}