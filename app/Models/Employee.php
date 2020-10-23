<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;

    /**
     * Get managed projects
     */
    public function managed_projects()
    {
        return $this->hasMany('App\Models\Project', 'manager_id');
    }
}
