//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StoreFront.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class ShoppingCart_table
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ShoppingCart_table()
        {
            this.ShoppingCartProduct_table = new HashSet<ShoppingCartProduct_table>();
        }
    
        public int ShoppingCartID { get; set; }
        public int UserID { get; set; }
        public Nullable<System.DateTime> DateCreated { get; set; }
        public string CreatedBy { get; set; }
        public Nullable<System.DateTime> DateModified { get; set; }
        public string ModifieidBy { get; set; }
    
        public virtual User_table User_table { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<ShoppingCartProduct_table> ShoppingCartProduct_table { get; set; }
    }
}
