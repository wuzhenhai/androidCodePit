<?php
namespace application\admin\controller;
use application\admin\controller\CommonController;
use application\admin\model\ModuleGroup;
use think\Db;
use think\Request;
/**
 * author   :  mzj
 * creatTime: 2017/3/9
 * description:
 */
class ModuleController extends CommonController {

   public function index(){
       $res=new ModuleGroup();
       $lists=$res->getGroups();
       $this->assign("lists",$lists);
      return $this->fetch();
   }


    public function add_module_info(){
        $tech_list=Db::name('tech_group')->select();
        $this->assign("tech_list", $tech_list);


        return $this->fetch();
    }

}