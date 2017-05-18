<?php
/**
 * author   :  mzj
 * createTime: 2017/5/18
 * description:
 */

namespace application\index\model;
use think\Model;

class Topic extends Model
{

    function getTopicById($id){
        $skill_id = $id ? intval($id) : 0;

        $skill_info = $this->where("id=" . $skill_id)->find();
        var_dump($skill_info);

        return $skill_info;
    }

    /**
     * 获取分类信息
     * @param string $where where子句
     * @param string $fields 要获取的字段名
     * @return array
     * @todo 根据where查询条件查找作品表中的相关数据并返回
     */
    public function getTopicInfo($where, $fields = '')
    {
        return $this->where($where)->field($fields)->find();
    }
}