<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Project extends Model
{
    use HasFactory;
    //protected $attributes = [
        //'delayed'
    //];

    /**
     * Get parent
     */
    public function parent()
    {
        return $this->belongsTo('App\Models\Project', 'parent_id');
    }


    /**
     * Get subprojects
     */
    public function subProjects()
    {
        return $this->hasMany('App\Models\Project');
    }

    /**
     * Get manager
     */
    public function manager()
    {
        return $this->belongsTo('App\Models\Employee', 'manager_id');
    }
}
