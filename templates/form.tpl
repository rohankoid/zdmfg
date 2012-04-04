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
    <?php if(!preg_match('/id/i', $column['field'])):?>
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
}
