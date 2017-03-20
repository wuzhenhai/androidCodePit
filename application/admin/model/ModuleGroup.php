<?php

/**
 *  
 * @file   AdminGroup.php  
 * @date   2016-8-30 18:22:31 
 * @author Zhenxun Du<5552123@qq.com>  
 * @version    SVN:$Id:$ 
 */

namespace application\admin\model;
use think\Db;
use think\Model;

class ModuleGroup extends Model {

    public function getGroups()
    {
        $modulelist = $this->allowField(true)->where('module_id', ">", 1)->order('module_id', 'asc')->select();
        return $modulelist;
    }

}
