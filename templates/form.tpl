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
         * @var Zend_Form_Element_Checkbox <?=$column['capital'] . "\n"?>
         */
         $this->addElement('checkbox','<?=$column['capital']?>', array('label'=>'<?=$column['label']?>'));
    <?php elseif ($column['type'] == 'text') :?>

        /**
         * Form Element type TextArea
         *
         * @var Zend_Form_Element_TextArea <?=$column['capital'] . "\n"?>
         */
        $this->addElement('textarea', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $this->getElement('<?=$column['capital']?>')
        <? if ($column['required']) { ?>
             ->setRequired(true)
        <? } ?>
             ->addFilter('StringTrim');
    <?php else :?>

        /**
         * Form Element type Text
         *
         * @var Zend_Form_Element_Text <?=$column['capital'] . "\n"?>
         */
        $this->addElement('text', '<?=$column['capital']?>', array('label' => '<?=$column['label']?>'));
        $this->getElement('<?=$column['capital']?>')
        <? if ($column['required']) { ?>
             ->setRequired(true)
        <? } ?>
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
    }
}
