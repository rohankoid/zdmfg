<?="<?php\n"?>

/**
 * Application Forms
 *
 * @package <?=$this->_namespace?>Form
 * @subpackage Form
 * @author <?=$this->_author."\n"?>
 * @copyright <?=$this->_copyright."\n"?>
 * @license <?=$this->_license."\n"?>
 */

class <?=$this->_namespace?>Form_<?=$this->_className?> extends <?=$this->_includeForm->getParentClass() . "\n"?>
{
    public function _init()
    {
    <?php foreach ($this->_columns as $column): ?>
    <?php if(!preg_match('/_id/i', $column['field']) && strtolower(substr($column['field'], 0, 2)!= 'id')):?>
    <?php if($column['phptype'] == 'boolean'):?>

        /**
         * Form Element type CheckBox
         *
         * Zend_Form_Element_Checkbox <?=$column['capital'] . "\n"?>
         */
         $this->addElement('checkbox','<?=$column['capital']?>', array('label'=>'<?=$column['label']?>'));

    <?php elseif ($column['type'] == 'text') :?>

        /**
         * Form Element type TextArea
         *
         * Zend_Form_Element_TextArea <?=$column['capital'] . "\n"?>
         */
        $this->addElement('textarea', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $this->getElement('<?=$column['capital']?>')
        <? if ($column['required']) { ?>
             ->setRequired(true)
        <? } ?>
             ->addFilter('StringTrim');
    <?php elseif (preg_match('/password/i', $column['field'])) :?>

        /**
         * Form Element type Password
         *
         * Zend_Form_Element_Password <?=$column['capital'] . "\n"?>
         */
        $this->addElement('password', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $this->getElement('<?=$column['capital']?>')
        <? if ($column['required']) { ?>
             ->setRequired(true)
        <? } ?>
             ->addFilter('StringTrim');
    <?php elseif (preg_match('/enum/i', $column['type'])) :?>

        /**
         * Form Element type Select
         *
         * Zend_Form_Element_Select <?=$column['capital'] . "\n"?>
         */
        $this->addElement('select', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $<?=lcfirst($column['capital'])?> = $this->getElement('<?=$column['capital']?>');
        $options = <?=preg_replace('/enum/i', 'array', $column['type'])?>;
        $<?=lcfirst($column['capital'])?>->addMultiOption('', '- Select One -');
        foreach ($options as $option) {
                $<?=lcfirst($column['capital'])?>->addMultiOption($option, $option);
            }
        $<?=lcfirst($column['capital'])?>->setRequired(true);
    <?php else :?>

        /**
         * Form Element type Text
         *
         * Zend_Form_Element_Text <?=$column['capital'] . "\n"?>
         */
        $this->addElement('text', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $this->getElement('<?=$column['capital']?>')
        <? if ($column['required']):?>
        ->setRequired(true)
        <? endif; ?>
        <?php if ($column['phptype'] == 'double' || $column['phptype'] == 'float') :?>
->addValidator('float')
        <?php elseif ($column['phptype'] == 'int') :?>
->addValidator('int')
        <?php elseif (preg_match('/email/i', $column['field'])) :?>
->addValidator('email')
        <? endif;?>
    ->addFilter('StringTrim');
    <?endif;?>
    <?endif;?>
        <?php endforeach;?>

    <?php foreach ($this->getForeignKeysInfo() as $key): ?>
    
        /**
         * Form Element type Select
         *
         * Zend_Form_Element_Select <?=$this->_getRelationName($key, 'parent') . "\n"?>
         */
        $this->addElement('select', '<?=$this->_getRelationName($key, 'parent')?>', array('label' => '<?=$key['foreign_tbl_name']?>'));
        $<?=lcfirst($this->_getRelationName($key, 'parent'))?> = $this->getElement('<?=$this->_getRelationName($key, 'parent')?>');
        $modelObj = new <?=$this->_namespace?>Model_<?=$this->_getClassName($key['foreign_tbl_name'])?>;
        $<?=lcfirst($this->_getRelationName($key, 'parent'))?>->addMultiOption('', '- Select One -');
        foreach ($modelObj->getMapper()->fetchAllToArray() as $row) {
                $<?=lcfirst($this->_getRelationName($key, 'parent'))?>->addMultiOption($row['<?=$key['foreign_tbl_column_name']?>'], $row['<?=$key['foreign_tbl_name']?>']);
            }
        $<?=lcfirst($this->_getRelationName($key, 'parent'))?>->setRequired(true);

    <?php endforeach;?>

        /**
         * Form Element type Submit
         *
         * Zend_Form_Element_Submit submit
         */
        $this->addElement('submit', 'Submit', array('label' => 'Submit'));
        $this->getElement('Submit')
             ->setIgnore(true);
    }

    /**
     * Maps <?=$this->_namespace?>Form_<?=$this->_className?> form's array of
     * data to <?=$this->_namespace?>Model_<?=$this->_className?> object
     *
     * @param Array $data
     * @param <?=$this->_namespace?>Model_<?=$this->_className?> $modelObj
     */
    public function mapFormToDb($data, <?=$this->_namespace?>Model_<?=$this->_className?> $modelObj)
    {
    <?php foreach ($this->_columns as $column): ?>
    <?php if(!preg_match('/_id/i', $column['field']) && strtolower(substr($column['field'], 0, 2)!= 'id')):?>

        $modelObj->set<?=$column['capital']?>($data['<?=$column['capital']?>']);
    <?php endif;?>
    <? endforeach;?>
    <?php foreach ($this->getForeignKeysInfo() as $key): ?>

        $modelObj->set<?=$this->_getCapital($key['column_name'])?>($data['<?=$this->_getCapital($key['column_name'])?>']);
    <?php endforeach;?>
        
    }

    /**
     * Map <?=$this->_namespace?>Model_<?=$this->_className?> Object Elements to <?=$this->_namespace?>Form_<?=$this->_className?> form's Array
     *
     * @param <?=$this->_namespace?>Model_<?=$this->_className?> $modelObj
     * @return Array $data
     */
     public function mapDbToForm(<?=$this->_namespace?>Model_<?=$this->_className?> $modelObj)
     {
    <?php foreach ($this->_columns as $column): ?>
    <?php if(!preg_match('/_id/i', $column['field']) && strtolower(substr($column['field'], 0, 2)!= 'id')):?>

        $data['<?=$column['capital']?>']= $modelObj->get<?=$column['capital']?>();
    <?php endif;?>
    <? endforeach;?>
    <?php foreach ($this->getForeignKeysInfo() as $key): ?>
        
        $data['<?=$this->_getCapital($key['column_name'])?>']= $modelObj->get<?=$this->_getCapital($key['column_name'])?>();
    <?php endforeach;?>

        return $data;
     }
}
