component displayname="ckEditor" output="false" author="Reuben Brown" support="reubenbrown13@gmail.com" {

	public function init(){
		this.version = "2.0";
		return this;
	}

	/**
	 * Builds and returns a string containing a text area field form control based on the supplied objectName and property.
	 * Note: Pass any additional arguments like class, rel, and id, and the generated tag will also include those values as HTML attributes.
	 *
	 * [section: View Helpers]
	 * [category: Form Object Functions]
	 *
	 * @objectName [see:textField].
	 * @property [see:textField].
	 * @association [see:textField].
	 * @position [see:textField].
	 * @label [see:textField].
	 * @labelPlacement [see:textField].
	 * @prepend [see:textField].
	 * @append [see:textField].
	 * @prependToLabel [see:textField].
	 * @appendToLabel [see:textField].
	 * @errorElement [see:textField].
	 * @errorClass [see:textField].
	 * @encode [see:styleSheetLinkTag].
	 */
	public string function textArea(
		required any objectName,
		required string property,
		string association,
		string position,
		string label,
		string labelPlacement,
		string prepend,
		string append,
		string prependToLabel,
		string appendToLabel,
		string errorElement,
		string errorClass,
		boolean richText = false,
		any encode
	) {
		$args(name="textArea", reserved="name", args=arguments);
		arguments.objectName = $objectName(argumentCollection=arguments);
		if (!StructKeyExists(arguments, "id")) {
			arguments.id = $tagId(arguments.objectName, arguments.property);
		}
		local.before = $formBeforeElement(argumentCollection=arguments);
		local.after = $formAfterElement(argumentCollection=arguments);
		if ( arguments.richText AND StructKeyExists(arguments, "id") ) {
			// set CKEditor URL for the CDN to Use
			local.ckeditorURl="https://cdn.ckeditor.com/ckeditor5/11.1.1/classic/ckeditor.js";
			local.after = local.after & "
			<script>
				ClassicEditor
					.create( document.querySelector( '###arguments.id#' ) )
					.catch( error => {
							console.error( error );
					} );
			</script>";
			cfhtmlhead( text='<script src="#local.ckeditorURl#"></script>' );
		}
		arguments.name = $tagName(arguments.objectName, arguments.property);
		local.content = $formValue(argumentCollection=arguments);
		return local.before & $element(name="textarea", skip="objectName,property,label,labelPlacement,prepend,append,prependToLabel,appendToLabel,errorElement,errorClass,association,position,encode", skipStartingWith="label", content=local.content, attributes=arguments, encode=arguments.encode) & local.after;
	}
}
