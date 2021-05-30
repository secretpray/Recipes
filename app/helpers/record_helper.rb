module RecordHelper

  def dom_id_for_records(*records, prefix: nil)
    records.map do |record|
      'form_' + dom_id(record, prefix)
    end.join("_")
  end

  def set_label(object)
    object.persisted? ? "#{t('.edit')}" : "#{t('.create')}"
  end
end
