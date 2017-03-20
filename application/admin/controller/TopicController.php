<?php
namespace application\admin\controller;
use application\admin\controller\CommonController;
use application\admin\model\ModuleGroup;
use application\admin\model\TopicGroup;
use think\Db;
use think\Request;
/**
 * author   :  mzj
 * creatTime: 2017/3/9
 * description:
 */
class TopicController extends CommonController {

    public function index()
    {
        $res=new TopicGroup();
        $lists=$res->getGroups();
        $this->assign("lists",$lists);
        return $this->fetch();
    }


    public function add_topic_info(){
        $tech_list=db('tech_group') ->select();
        $this->assign("tech_list", $tech_list);

        $module_list=new ModuleGroup();
        $module_list=$module_list->getGroups();
        $this->assign("module_list", $module_list);

        return $this->fetch();
    }


    public function add(){
        $data = input();
        $data['module_id'] = intval($data['module_id']);

        $module_name= Db::name('module_group')->where('module_id','=',  $data['module_id'] )->find();
        $data{'module_name'}=$module_name['module_name'];

        $topic=new TopicGroup();
        $topic->addTopic($data);

        if ($topic){
            $this->success('操作成功', url('index'));
        }else{
            $this->error('操作失败');
        }
    }

}