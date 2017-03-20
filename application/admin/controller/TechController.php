<?php

namespace application\admin\controller;

use think\Db;


class TechController extends CommonController {

    public function index() {
        $res = db('tech_group')->select();
        $this->assign('lists', $res);
        return $this->fetch();
    }



    public function add_tech_info(){
        return $this->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        $data = input();
        if (empty($data['tech_name'])){
            $this->error('请填写技能类型');
        }

        $res = Db::name('tech_group')->insert($data);;
        if ($res) {
            $this->success('操作成功', url('index'));
        } else {
            $this->error('操作失败');
        }
    }

}
